Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6105768FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjGaIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGaILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:11:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D376F1BC;
        Mon, 31 Jul 2023 01:07:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V6xcvi030927;
        Mon, 31 Jul 2023 08:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GsmGA04Aq/4sirD7eMpQWZAa/t+hd9ql4R9SolXLrAo=;
 b=A1I4KVPOifKTnv/4i9IvLR9kBrx0UEyc6E9DaQq1WQyyzbKV03LPCkJPf/wpwfT9/kmS
 BVeH54N6pmazpMfOjKcidySq145YJwRMdYkF7dA2PISQBLkzu5Eg1BmZzZKrjoz752Wz
 k9wsfzA4BtvZEAQpavHsMaE7v3Mw/gxEqjVCkblawGgq5Ut39k86LKQtevzVpU0VzBNI
 xy9qvIC4MSIIOQCz+uGJNqPWgPSftuwUN5skbe1jz7E/yQGj6LujDlmGTZPXAgX1Z6tf
 sRJpXREUqxtgRMAZ3W6s7T2hQO2RsJS9+dgk1mAlJwMXXYGHqACo4fnLE4hzrw9q/c+P qA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uat2yfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 08:07:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V87p4P019889
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 08:07:51 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 01:07:46 -0700
Message-ID: <ad6aba3b-f8b8-9cf5-aa50-ad34a7406b5d@quicinc.com>
Date:   Mon, 31 Jul 2023 16:07:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] dt-bindings: arm: qcom,ids: Adjust the position of
 QCOM_ID_QDU1010
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731061325.26431-1-quic_tengfan@quicinc.com>
 <20230731061325.26431-6-quic_tengfan@quicinc.com>
 <981a79ee-5258-eb76-020a-765f5f39866f@linaro.org>
 <53132580-53b6-06bc-8b48-51a3f56ab71d@quicinc.com>
 <dc327138-0fc2-0766-0d86-08977b07fb76@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <dc327138-0fc2-0766-0d86-08977b07fb76@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S3v6vyUGcSgMNsl5Gjncj0eTJsg3ddb6
X-Proofpoint-GUID: S3v6vyUGcSgMNsl5Gjncj0eTJsg3ddb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_01,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=595 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/31/2023 4:02 PM, Krzysztof Kozlowski 写道:
> On 31/07/2023 09:21, Tengfei Fan wrote:
>>
>>
>> 在 7/31/2023 3:00 PM, Krzysztof Kozlowski 写道:
>>> On 31/07/2023 08:13, Tengfei Fan wrote:
>>>> Adjust the position of QCOM_ID_QDU1010, so that there is a coherent
>>>> sequence of numbers.
>>>>
>>>> Change-Id: Id083e1ecc92c063c1a07a81c66dcb034020964b0
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>>> warnings can be ignored, but the code here looks like it needs a fix.
>>> Feel free to get in touch if the warning is not clear.
>>>
>> sure, will do this check if this patch still need.
> 
> I understand that resending this might not be needed, but just to
> clarify: you must run checkpatch on all your patches before sending
> them. This is the most basic step required before sending anything.
> 
> Best regards,
> Krzysztof
> 
Thanks Krzysztof remind me kindly, will do checkpatch confirm if have 
other patch need push to upstream.
new patcheset already remove this patch, and already got your review, 
Thanks again!

-- 
Thx and BRs,
Tengfei Fan
