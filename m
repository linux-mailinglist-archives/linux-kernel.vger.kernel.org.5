Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E937F0C02
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 07:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjKTGxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 01:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTGxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 01:53:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C9E93;
        Sun, 19 Nov 2023 22:52:59 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK4T77n024823;
        Mon, 20 Nov 2023 06:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IJXBAdWU4kpgnwT9Z+W4yVnLvPVTUtZr5f3lVFzomE4=;
 b=CHVqe9Rfl0k9RhaI5cer13uASUovallAtdW+aC6OyWGNH5PbKOU7/FUUOfsW/yZaxyDG
 PqhXGi1A9z/0z5dRArQoOyfjgLCMB2tnweVqxKTgarESr6M+CixPmQ89HYpFACegr3qC
 d0T5Hlbm8qKFuVMkMq66+Q9Ff4sGag5Rf9zh1v9oeVwjsykCxD8GxlENq6PgOw1dmiKF
 VdzAcQ5sVAnK/dbm1nJIucp347H0hu34EO373QqMQtEM1QKVBXRqdxGbsfpUrvDkAS//
 DLVEwH72q2dwLURBsO6+eGz5gQdEsqdOXi1PWgmPMgPyIxZO8oHKmgAjLIUwB7YnCT8w 9w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug0ey0b0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:52:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK6qsfM016034
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:52:54 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 19 Nov
 2023 22:52:49 -0800
Message-ID: <0aa142c8-c1cb-df6a-b5fd-6470c95bcef9@quicinc.com>
Date:   Mon, 20 Nov 2023 12:22:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: power: rpmpd: Update part number to
 X1E80100
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>
References: <20231117104254.28862-1-quic_sibis@quicinc.com>
 <20231117104254.28862-2-quic_sibis@quicinc.com>
 <8fafbba6-86de-4ddc-966e-48e2152f6b1a@linaro.org>
 <97216704-a102-532d-1039-c9342a19e2fd@quicinc.com>
 <81a1bfee-851c-4f05-b816-47abcebed99c@linaro.org>
 <796fd7be-2008-460e-acf7-e335de780104@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <796fd7be-2008-460e-acf7-e335de780104@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8T0wqCVPv4dLqvp53u_ArKnGCU7F2cTh
X-Proofpoint-ORIG-GUID: 8T0wqCVPv4dLqvp53u_ArKnGCU7F2cTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_04,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=849 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200043
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/23 05:10, Konrad Dybcio wrote:
> On 17.11.2023 13:39, Krzysztof Kozlowski wrote:
>> On 17/11/2023 12:46, Sibi Sankar wrote:
>>> Hey Krzysztof,
>>>
>>> Thanks for taking time to review the series.
>>>
>>> On 11/17/23 16:35, Krzysztof Kozlowski wrote:
>>>> On 17/11/2023 11:42, Sibi Sankar wrote:
>>>>> Replace SC8380xp with the updated part number (X1E80100).
>>>>>
>>>>
>>>> You need to explain why. We don't update compatibles based on marketing
>>>> wishes.
>>>
>>> What we imply is that X1E80100 is the part number you would get when you
>>> read out from a Snapdragon X Elite device in the wild, when it is
>>> available and we didn't have this information when we posted out v1.
>>
>> The commit msg must explain why.
> (what Krzysztof meant is that your explanation is ok but it needs to be
> part of the commit message and not just a reply here)
> 
> Moreover, it would also be good to say something like "this binding has
> no users and has been erroneusly introduced very recently, so it was
> decided that changing it is okay", as this is a rather special case.

Thanks, was going to do the same.

-Sibi

> 
> Konrad
