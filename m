Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9428E7CC3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbjJQNHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQNHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:07:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E7F5;
        Tue, 17 Oct 2023 06:07:47 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HBdQ1b003954;
        Tue, 17 Oct 2023 13:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mY6yTJr+pQUryKyV1XMaz8CaGnDEXk72DW9irY+22p4=;
 b=HBWAhdNemcHaSG/DjfgsdfadZykLZhGCOVy8yYqgQidYL7zocBBmaqp6z0yXU/jvWOmt
 o171COMdvFivfWNqn+PRGgCvehsDLzhVpQiwTFD4VtGYb3ImfrJu7UZEKMPwCfI8wec2
 VXymvnctelQWUzwnIStR9BipATy9BpZ3ltWUJ9pvGpjUCpN2He1tKl96mdD2XR8Ovhhy
 kd5mlh9L4S+VxVrBGAz4SXZF6a5kWDPTkGvM3nrNT7yzxJm7WubPu/ivu3Z5KaPYagXt
 3o0OV9EXpm2kd07KOp52aXN6J7Ibv1SJaZ7EZeU0R9LJPu/RXVhlrQDtImR+URVy69X5 2A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsc00std7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:07:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HD7fsS020244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:07:41 GMT
Received: from [10.201.2.147] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 06:07:36 -0700
Message-ID: <f44b6e59-c26e-1026-49b7-e02ff02d7562@quicinc.com>
Date:   Tue, 17 Oct 2023 18:37:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Sricharan R <srichara@win-platform-upstream01.qualcomm.com>,
        <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-5-srichara@win-platform-upstream01.qualcomm.com>
 <1c6ecc92-89d3-3b7e-c2d0-e2fded9b446d@gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <1c6ecc92-89d3-3b7e-c2d0-e2fded9b446d@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XqWkhRgvXBsiD5jeQCMKxW9tf_mbu868
X-Proofpoint-GUID: XqWkhRgvXBsiD5jeQCMKxW9tf_mbu868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 clxscore=1011 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170110
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 12:38 AM, Robert Marko wrote:
> 
> On 22. 09. 2023. 13:51, Sricharan R wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> IPQ5018 has tsens V1.0 IP with 4 sensors.
>> There is no RPM, so tsens has to be manually enabled. Adding the tsens
>> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
>> critical temperature being 120'C and action is to reboot. Adding all
>> the 4 zones here.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [v3] Ordered the qfprom device node properties as per
>>        Krzysztof's comments
>>
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..9e28b54ebcbd 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -93,6 +93,117 @@ soc: soc@0 {
>>           #size-cells = <1>;
>>           ranges = <0 0 0 0xffffffff>;
>> +        qfprom: qfprom@a0000 {
>> +            compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
> Hi,
> 
> "qcom,ipq5018-qfprom" needs to be documented in QFPROM bindings first.

  Already posted here [1]. Initially had it in the same series, but kept
  it separately based on review comments.

  [1] https://www.spinics.net/lists/devicetree/msg633408.html

Regards,
  Sricharan
