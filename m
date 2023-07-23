Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B85E75E218
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGWNdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:33:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F5D10DC;
        Sun, 23 Jul 2023 06:33:49 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NDVoWe018898;
        Sun, 23 Jul 2023 13:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/zRygFxep4I/hzO0qe76/3c+2dFGWUlJIzmD/z6DibU=;
 b=By+zk12pVfbaSE8TOjrmcva22wC/wWYN7H+mlGF6nB9GzOCHvgK66FGq41yfUCoQcAwZ
 0ZzJzDkNgNiOf1diSNzp7OJaKVErBGE6Ob0+a/WYp0edh69ZAXXWY8UxVl5Brk4CPwMV
 E9vhW0b5YA57AFhaHaFQUW3uet6mj3axnYjuoEWRgP4D6G7XBH+/jmV5thIhQ7CD5lnE
 uLX37/K9Ywpa8KU/w+ShvkghCJhCaKQuX8Fw7P8ERJrLV7CxLxgCPdotOV18JgR7c7+D
 eeTYlc5pZpvhsHLleUoHEKrNoFGG1P+ckWgMNNe3Irw2ZJStPl//Vo65c2lTfCrrgExp 0A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s089tsgy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 13:33:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36NDXd8Y031337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 13:33:39 GMT
Received: from [10.216.27.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 23 Jul
 2023 06:33:35 -0700
Message-ID: <06c8e7c6-91e9-7f6b-1feb-d94ce88ebb26@quicinc.com>
Date:   Sun, 23 Jul 2023 19:03:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 1/2] dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC
 ID
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_saahtoma@quicinc.com>
References: <20230712041912.398724-1-quic_kathirav@quicinc.com>
 <20230712041912.398724-2-quic_kathirav@quicinc.com>
 <20230714155954.GA3919199-robh@kernel.org>
 <dba8ab0a-c17b-8660-5c5a-803e7f394547@quicinc.com>
 <e4fub7xxkiupbkszaxwu4x5otdi7afvyl334ybwlxafkbxfw3c@cd4gja5u6st6>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <e4fub7xxkiupbkszaxwu4x5otdi7afvyl334ybwlxafkbxfw3c@cd4gja5u6st6>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GIybfryqChpFPHCsz-EBlg1lzd0QCUep
X-Proofpoint-ORIG-GUID: GIybfryqChpFPHCsz-EBlg1lzd0QCUep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=650
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230125
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/2023 9:32 AM, Bjorn Andersson wrote:
> On Sat, Jul 15, 2023 at 08:41:56PM +0530, Kathiravan T wrote:
>> On 7/14/2023 9:29 PM, Rob Herring wrote:
>>> On Wed, Jul 12, 2023 at 09:49:11AM +0530, Kathiravan T wrote:
>>>> IPQ5019 SoC is never productized. So lets drop it.
>>> You need to remove the user before removing the definition.
>> Rob, Currently there are no users for this macro.
>>
> But you're removing a user in patch 2? Or am I reading that incorrectly?


My bad. Sorry, I misunderstood the Rob's statement. Let me send the V3 
in the correct order.


>
> Regards,
> Bjorn
