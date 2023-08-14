Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919B477BFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHNSpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjHNSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:44:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99A1718;
        Mon, 14 Aug 2023 11:44:28 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIKXaw001756;
        Mon, 14 Aug 2023 18:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SpgGKHaduwL36ft3cIlrRRhxImV4rgAUfwuQWWQnv8k=;
 b=Zs4hdpsNvDFFGc3m+uyg22lgJxTJwRNUahU6hqosbuAqoAJlzH2970Cux3GsHlZ1eKXU
 bwAWMO+Is1NJ9Gg44YOp7l3rkMp4JN06/RhmSm57VYWvVE6oe48ehmf9oDRi9Vi6Q9/U
 1fGeAoNZ6pzsWeKuYBeoNxKCIAR9dTNxx3xLXnIS2TAixE5v58BdRq7o29D+8e0iD5Vz
 srEVxdoY2ehJj9DnavHU6ZD+NTdd6LBzkMHqTwsf3d22wLiWtImpbQO5GeI8wKTUpp9+
 Q3xG1fo8XAY1uwGzrXz9WjHgjGEXkIUszY+6/vBtgnzTwccPt2Iyet/w8aPNu8cm2i43 mA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3j94mja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:44:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EIiJ7K009009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:44:19 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 11:44:15 -0700
Message-ID: <b4de638e-9cab-2662-92b0-e2d1a18018a1@quicinc.com>
Date:   Tue, 15 Aug 2023 00:14:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/33] MAINTAINERS: Add Qualcomm Iris video accelerator
 driver
To:     Randy Dunlap <rdunlap@infradead.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-2-git-send-email-quic_vgarodia@quicinc.com>
 <c29d5e28-5b9d-1327-0feb-e5ed27afcd3a@infradead.org>
Content-Language: en-US
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <c29d5e28-5b9d-1327-0feb-e5ed27afcd3a@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rfxZxM8UNtrUJgD6bhcTm9lG7Le3srwM
X-Proofpoint-GUID: rfxZxM8UNtrUJgD6bhcTm9lG7Le3srwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140173
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2023 4:18 AM, Randy Dunlap wrote:
> 
> 
> On 7/28/23 06:23, Vikash Garodia wrote:
>> Add an entry for Iris video encoder/decoder accelerator driver.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>  MAINTAINERS | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3be1bdf..ea633b2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17671,6 +17671,16 @@ T:	git git://linuxtv.org/media_tree.git
>>  F:	Documentation/devicetree/bindings/media/*venus*
>>  F:	drivers/media/platform/qcom/venus/
>>  
>> +QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
> 
> This entry should immediately follow:
> QUALCOMM IPQ4019 VQMMC REGULATOR DRIVER
> 
> to keep the file in alphabetical order.
> 
Sure, will fix this in next version.

Thanks,
Dikshita

>> +M:	Vikash Garodia <quic_vgarodia@quicinc.com>
>> +M:	Dikshita Agarwal <quic_dikshita@quicinc.com>
>> +L:	linux-media@vger.kernel.org
>> +L:	linux-arm-msm@vger.kernel.org
>> +S:	Maintained
>> +T:	git git://linuxtv.org/media_tree.git
>> +F:	Documentation/devicetree/bindings/media/qcom,*-iris.yaml
>> +F:	drivers/media/platform/qcom/iris/
>> +
>>  QUALCOMM WCN36XX WIRELESS DRIVER
>>  M:	Loic Poulain <loic.poulain@linaro.org>
>>  L:	wcn36xx@lists.infradead.org
> 
