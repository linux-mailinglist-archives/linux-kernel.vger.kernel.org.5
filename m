Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA887F222C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjKUAfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKUAfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:35:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F247B4;
        Mon, 20 Nov 2023 16:35:36 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL0Ukiu004194;
        Tue, 21 Nov 2023 00:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LjYccTzR/e/RKH1HM/glpxOGlx3XM8m2TLAC51Oyg2M=;
 b=gUA1/3MMfBIPRc6PgmT/Vty/6j6MU50/Ao6q/OvOij10sUi5vDrk4qVKyF1WVTixEr++
 ZHWLXfCeUF0k82MbazguBw5AI/3R4w21b3KGVzGt+tUySSo96iDPOl8sf/1ERi5nhLjs
 +T8B3o4AOtcU7QzwuioQjivpvx/kRiILZ6FqnXGanYiZzPEm5FbzGqozF1ATEyjXofvr
 lcu/O4NqQ+RK8Kn4ZZ6+wV87N3QxaxiG8AEBm+EFqWrFvfbZqGycQtS/Z3v/nX64gCGM
 EBOcoD9W/rIgGI0o1QVsX93X8T2I30FHc5MsRvm+vhSraLKtEuRf+dEDE58wzaO4gRZP PA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugdxmget5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:35:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL0ZLEZ028770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:35:21 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 16:35:18 -0800
Message-ID: <ff6f8a6b-0c04-44f3-aaf8-70d9695b4f4e@quicinc.com>
Date:   Tue, 21 Nov 2023 08:35:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] arm64: dts: qcom: sm8550: update Soundwire node
 name
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <-cc=kernel@quicinc.com>
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-4-quic_tengfan@quicinc.com>
 <eba08b4d-6df0-419f-aa79-3ac6b6195bc2@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <eba08b4d-6df0-419f-aa79-3ac6b6195bc2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BlzM2_fcKpv_8m0IOlBOgRezUMn_qm3I
X-Proofpoint-ORIG-GUID: BlzM2_fcKpv_8m0IOlBOgRezUMn_qm3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=555 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/17/2023 6:24 PM, Krzysztof Kozlowski 写道:
> On 17/11/2023 11:18, Tengfei Fan wrote:
>> Update Soundwire node name from "soundwire-controller" to "soundwire"
>> for avoid dtbs check warning.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> I see PDC duplicated, now I see this patch as well, so you just repeated
> everything which we did already?
> 
> Best regards,
> Krzysztof
> 


Thanks Krzysztof remind kindly, I will check upstream patch for getting 
this patch and I will do "depend on" on my new patch series.

-- 
Thx and BRs,
Tengfei Fan
