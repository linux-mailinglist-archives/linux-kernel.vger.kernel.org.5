Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97B97F22DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjKUBHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjKUBHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:07:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2DBDC;
        Mon, 20 Nov 2023 17:07:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKN4bow029277;
        Tue, 21 Nov 2023 01:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DjAK686IwaY7TYo5SPGNQy83Wk8s+2JTIU2aMuGD/zg=;
 b=YEKkQI6CKno3AJCHcRZP8JQKq4bz9hxbPe37qnkTTCxl0uiEvGjR7URHwYPcxWq5giJz
 0I1uhRJOuLyuzKW8PVjdXv4h/6eqVQ5Dj5dmJ9B94ltoJ0kmPGr244wLjSJAN2g5WFdP
 Ig4V+zSFi0H2TTJuFZoZlMsm48bJZJvWuOuS87mICzTrHMy2AIIxhMjjYLujzEGpN9ZX
 Iny9K4b6Bkuog/cQRSLtOgPdDPRe8k5CHDU5O6gGtX1ehXE8Rv7te6Fgv8KWsFzgBb6S
 xc9Za3FqcCtt+EA/Kl9jVUg0N+0YGB2Q/U+15Nv2k/H1947u5FWQpT7iZigoPzByZsI9 yA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug5371wy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 01:07:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL16xSA007449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 01:06:59 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 17:06:56 -0800
Message-ID: <877de56b-7ce7-4136-a2ae-fe09ad165229@quicinc.com>
Date:   Tue, 21 Nov 2023 09:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] arm64: dts: qcom: sm8550-aim300: add bluetooth
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <-cc=kernel@quicinc.com>
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-17-quic_tengfan@quicinc.com>
 <42eacc5c-3411-4a1f-8d9c-b1fc43ad470e@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <42eacc5c-3411-4a1f-8d9c-b1fc43ad470e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HCnh6QsOakIHKcUjrtEMyiHnfZvkKOmq
X-Proofpoint-GUID: HCnh6QsOakIHKcUjrtEMyiHnfZvkKOmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=636 spamscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/17/2023 6:33 PM, Krzysztof Kozlowski 写道:
> On 17/11/2023 11:18, Tengfei Fan wrote:
>> Enable the WCN7850 bluetooth over the UART14 link.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> NAK, it's initial submission.
> 
> Stop useless splitting of work which is done. You cannot have "release
> late, release often". The rule is: "release early, release often".
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,
In next version patch series, I'm going to combine all the splited 
functions into one patch.

-- 
Thx and BRs,
Tengfei Fan
