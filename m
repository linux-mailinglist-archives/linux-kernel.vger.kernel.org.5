Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8F7F6138
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbjKWOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbjKWOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:16:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F39D40;
        Thu, 23 Nov 2023 06:16:33 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANCZU3o021136;
        Thu, 23 Nov 2023 14:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rIZzymLS3Ylg8j6esSrxq5S21SMx81sxQPWuNmJzoJ0=;
 b=mqaDA+HiacW0dFoqvU1vZaLbJL0GJtXtSvq6iqyiBSqams6lfY1r6Xu4D/EjARz5hMIs
 bIW5hLRWk1bqPKErhr5M0dgy+Jr3606WVLq2QsgIP4dxAZuRWgukOwcEtaPDdDWYqya4
 rN5XQKZZd597HiQ2qqo6XvvMcohVJXggJT3/C/jiT5UtnlFo0luSsWgQuymNK0vzca5M
 R+mPTJcyjqFIVWzHLuiRUfjA7MK1SNsYU7YJFrvoltmuoS2FrdYLPgoEUPDlfpubAV3s
 QoOueExg8ttZPnogsor6Lbxw5LI2QfbhxMudMs0Nq0cmBWa6m4PKJo0nTtGYsDaFZwL2 xg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj6emr7nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 14:16:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANEGTZP006361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 14:16:29 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 06:16:25 -0800
Message-ID: <9f0d2e6b-2648-083d-955c-484e9d899924@quicinc.com>
Date:   Thu, 23 Nov 2023 19:46:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: Add base qcs6490-rb3gen2 board
 dts
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naina Mehta <quic_nainmeht@quicinc.com>
References: <20231120134754.9526-1-quic_kbajaj@quicinc.com>
 <20231120134754.9526-4-quic_kbajaj@quicinc.com>
 <70402702-84d3-4577-9fd2-9e87add4283b@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <70402702-84d3-4577-9fd2-9e87add4283b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rWCSSSuUSpCKSNL32kasGDwHHIMIsfZI
X-Proofpoint-GUID: rWCSSSuUSpCKSNL32kasGDwHHIMIsfZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230103
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore if received twice.

On 11/20/2023 8:17 PM, Caleb Connolly wrote:
> 
> 
> On 20/11/2023 13:47, Komal Bajaj wrote:
>> Add DTS for Qualcomm qcs6490-rb3gen2 board which uses
>> QCS6490 SoC. This adds debug uart and usb support along
>> with regulators found on this board.
> 
> Hi,
> 
> I understand there was a lot of previous discussion around these two
> boards, sorry to be bringing it up again here, but I have a few more
> questions.
> 
> How similar are these two boards in terms of design? If they're derived
> from the same reference schematic then I think this is a good
> justification to de-duplicate the common DTS parts.

These two are different boards and they don't follow same schema.

> 
> Dropping them in a diff tool [1] it seems as though the only changes are
> the modem reserved memory for the IDP board, some minor regulator
> changes, and the sdcard on the IDP board being enabled. However it's
> important to differentiate between these just, being the same, vs them
> being based on the same reference design.

As I said in the other thread[1], the only difference between these two
boards is just the memory map, we can always comeback and do refactor if
there will be more common things to share between these IOT family
platforms.

[1]https://lore.kernel.org/linux-arm-msm/3d8a8943-af70-c291-d2d8-41067d8404f2@quicinc.com/

> 
> I left some comments on the parts that differ between the boards below,
> but basically my question is: do these boards share enough of the same
> *design* that it would make sense to have a "qcm6490-iot.dtsi" file with
> the common reserved memory and regulators?
> 
> The IDP and rb3 boards would then inherit from there, avoiding a lot of
> duplication and weirdness where some boards have certain regulator
> properties that others don't with it being hard to tell if this is
> intentional or not (this is the case with a lot of the existing upstream
> devices).
> 
> On a related note, should we further split the rb3 board into a
> qcs6490-whatever-som.dtsi file which may define the SoM specific parts?
> This would undoubtebly make it easier for other boards based on the same
> SoM to be bought up and kept up to date.
> 
> [1]: https://quickdiff.net/?unique_id=630F6851-C750-839E-1651-4CA6D997A74D
> 
> 

I agree with your comment to have a common qcs6490-som.dtsi, but will do
this once we upstream the other rb boards based this SoM.

> [...]
> 
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> new file mode 100644
>> index 000000000000..f023dcf768f1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -0,0 +1,410 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
> [...]
>> +
>> +		vreg_l7b_2p952: ldo7 {
> 
> The IDP board defined voltages here for the sdcard, does the rb3 board
> have an sdcard slot (if so which regulator does it use)?
> 
> Is there a reason not to define the same voltage range for this board?

This regulator in IDP board is used for mmc (sdhc_1) and rb3 does not
have it. Although both have sdcard and I have not pushed the support for
it yet. Will add the voltage ranges here as it was a mistake.

>> +			regulator-allow-set-load;
> 
> This property is set for rb3 but not for the idp board, even though this
> regulator is unused, should this be set?

Again this was some downstream hack that got copied. Sorry for this.
Will remove it.

>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
> [...]
>> +
>> +		vreg_l9b_1p2: ldo9 {
> Same question as above
>> +			regulator-allow-set-load;
> Same question
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
> [...]
>> +		vreg_l19b_1p8: ldo19 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <2000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> The IDP board has the regulator-allow-set-load property here, as well as
> regulator-allowed-modes. This regulator is used for the sdcard on that
> board. Is it used for anything on rb3? Can these properties be the same?

As explained above, this property is used for mmc and not sdcard. As of
now, not used.

Thanks,
Komal.

