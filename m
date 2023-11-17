Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87F7EF21B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbjKQLu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbjKQLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:50:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1FD4F;
        Fri, 17 Nov 2023 03:50:21 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHAgVOx005361;
        Fri, 17 Nov 2023 11:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SyCHP+/9otTRhmivNIVzlCY4QA4XfLWR9PgZhgzpqWA=;
 b=RB+40vcO64/S9Et4iqjojSBSpJlplxTaStEFzVHfzQGTvbSzuynfdrO5etp/nM7Fd81x
 Zwv6QCd9Op7d20jBRxIuQXk35ugurAO1z1j7kM34ypVz/FdezEn5TVNQIAq/2o/MyuSz
 tIp4etkcXfHAoEAdhvrDmxbjsl68EQwoRmRdX6PUrFwpmoskEe1DlI8GlMdWgHu3tXyz
 +0rmBvG2yDlvSA82ZI5KORpWEQj/wdLTcPo7nK9LJjFSFSuf3svLiv18LIAD7DMX7BnU
 qZvCm8kllMhTeh4YEnMWuS3PaDGfLCiG4dGv7iQrbxf8azNcMtv+/rsnTlTkwYya1Zpm WA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udt8bskbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 11:50:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHBoIC9018615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 11:50:18 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 17 Nov
 2023 03:50:13 -0800
Message-ID: <2965dbc9-2e19-5bc1-dfde-a0b821fd5a59@quicinc.com>
Date:   Fri, 17 Nov 2023 17:20:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: Update part number to
 X1E80100
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>
References: <20231117104254.28862-1-quic_sibis@quicinc.com>
 <20231117104254.28862-3-quic_sibis@quicinc.com>
 <be3c67fa-29b4-430c-8de6-c4753e7831fa@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <be3c67fa-29b4-430c-8de6-c4753e7831fa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bwCHz7iyhghTr2Eujo9BMz_6cdseUNew
X-Proofpoint-GUID: bwCHz7iyhghTr2Eujo9BMz_6cdseUNew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_10,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=863 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170089
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,


On 11/17/23 16:36, Krzysztof Kozlowski wrote:
> On 17/11/2023 11:42, Sibi Sankar wrote:
>> Replace SC8380xp with the updated part number (X1E80100).
>>
>> Fixes: 2050c9bc4f7b ("pmdomain: qcom: rpmhpd: Add SC8380XP power domains")
> 
> No, there was no bug or at least you did not describe a bug. If it was a
> bug, please define it in the commit msg.

It's technically replacing an obsolete part number with the correct
on, so I thought using the fixes tag makes sense. Let me add more
details on the next re-spin.

-Sibi

> 
> Best regards,
> Krzysztof
> 
> 
