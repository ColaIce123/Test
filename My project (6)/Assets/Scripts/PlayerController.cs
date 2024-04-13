using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    //玩家动画机
    public Animator animator;
    //移动速度
    public float moveSpeed = 3f;
    //转向平滑度
    public float rotateSmooth = 10f;
    //玩家模型变换
    public Transform model;
    //相机变换
    public Transform cameraTF;

    void Update()
    {
        // 获取玩家输入
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");

        // 计算移动方向
        Vector3 moveDirection = new Vector3(horizontal, 0f, vertical).normalized;

        // 控制动画状态和移动
        if (moveDirection.magnitude >= 0.1f)
        {
            //根据Camera方向
            moveDirection = cameraTF.TransformDirection(moveDirection);
            MovePlayer(moveDirection);  //移动玩家
            RotatePlayer(moveDirection);//旋转玩家
            animator.SetBool(name: "Run", value: true);
        }
        else
        {
            animator.SetBool(name: "Run", value: false);
        }
    }

    void MovePlayer(Vector3 moveDirection)
    {
        // 将垂直方向设为0，只在水平方向移动
        moveDirection.y = 0f;
        // 计算移动向量并移动玩家
        transform.Translate(moveDirection * moveSpeed * Time.deltaTime, Space.World);
    }
    void RotatePlayer(Vector3 moveDirection)
    {
        // 通过移动方向旋转玩家
        Quaternion toRotation = Quaternion.LookRotation(moveDirection, Vector3.up);
        // 将旋转限制为只影响 Y 轴
        toRotation = Quaternion.Euler(0f, toRotation.eulerAngles.y, 0f);
        model.rotation = Quaternion.Slerp(model.rotation, toRotation, Time.deltaTime * rotateSmooth);
    }
}
