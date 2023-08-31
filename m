Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4C78ED1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbjHaMaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjHaMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:30:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10F81A4;
        Thu, 31 Aug 2023 05:30:46 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VBp03P005935;
        Thu, 31 Aug 2023 12:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BU00vg17G76ircAg1xz3lhcsO7N9Z7ZT+RXru3K620c=;
 b=ASJcHerclvq97OBC2NFYxwEecGWz4kfrHfYuEnqP6BUMkti/TjsPV6n5rREJ/exL02sF
 boCk/3Z3az3nEyWV9P9COSKnXwECSF8PFhLBuPSPwMK0bN9TuhVlLtEXgt0SHuUuy4Ov
 2cId14V5WFwSrPdRseQRdi/uG5tUcYzTDimJV3hpc8v2VsU7w6huWfyOOM45u4rpmY4C
 myEtaezW2RxXAonjp8l8NSmwHS3zuUQH7LeOfxtxz4RS68Yyml2716CBvlAmbdcPh6w0
 ZRzW5FAVZqoi5h3K09FVvi0SdHaRe48YA8Eq18M2UO32jZVTURGk51AsdtwAgSQ5lXjE qA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stpy98hnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 12:30:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VCU8Ss008797
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 12:30:08 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 31 Aug
 2023 05:30:00 -0700
Message-ID: <4e9a43c5-43ec-4a07-9053-366a517f5c54@quicinc.com>
Date:   Thu, 31 Aug 2023 17:59:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dt-bindings: phy: qcom,uniphy: Rename ipq4019 usb PHY
 to UNIPHY
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_varada@quicinc.com>
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-2-quic_ipkumar@quicinc.com>
 <CAA8EJpqA-poJ9=XKJa2s=yZUGbBbgOqgiDC-q9skJzBqLux84g@mail.gmail.com>
 <73879012-581d-47fb-b741-577c90b31dfb@quicinc.com>
 <CAA8EJpr3PJtvyYKRPqT=hO4sUd4oOjTvOjD3kOqffbjzHdByAw@mail.gmail.com>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <CAA8EJpr3PJtvyYKRPqT=hO4sUd4oOjTvOjD3kOqffbjzHdByAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9ehDmc-1lt6mX6pcugNoo-YAcP_FWp96
X-Proofpoint-GUID: 9ehDmc-1lt6mX6pcugNoo-YAcP_FWp96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/2023 5:47 PM, Dmitry Baryshkov wrote:
> On Thu, 31 Aug 2023 at 14:54, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>>
>> On 8/29/2023 7:49 PM, Dmitry Baryshkov wrote:
>>> On Tue, 29 Aug 2023 at 16:59, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>>>> UNIPHY / Combo PHY used on various qualcomm SoC's are very similar to
>>>> ipq4019 PHY. Hence renaming this dt-binding to uniphy dt-binding and
>>>> can be used for other qualcomm SoCs which are having similar UNIPHY.
>>>>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> ---
>>>>    .../phy/{qcom-usb-ipq4019-phy.yaml => qcom,uniphy.yaml}  | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>    rename Documentation/devicetree/bindings/phy/{qcom-usb-ipq4019-phy.yaml => qcom,uniphy.yaml} (78%)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
>>>> similarity index 78%
>>>> rename from Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
>>>> rename to Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
>>>> index 09c614952fea..cbe2cc820009 100644
>>>> --- a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
>>>> @@ -1,13 +1,18 @@
>>>>    # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>    %YAML 1.2
>>>>    ---
>>>> -$id: http://devicetree.org/schemas/phy/qcom-usb-ipq4019-phy.yaml#
>>>> +$id: http://devicetree.org/schemas/phy/qcom,uniphy.yaml#
>>>>    $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>
>>>> -title: Qualcom IPQ40xx Dakota HS/SS USB PHY
>>>> +title: Qualcomm UNIPHY
>>> We know that UNIPHY was a common design / IP block used for APQ8064
>>> SATA and MSM8974 DSI and HDMI PHYs. Is this the same design, or was
>>> the name reused by the Qualcomm for some other PHYs?
>>> Several latest generations have USB QMP PHYs which are called 'uni-phy'.
>> This PHY is build on top of QCA Uniphy 22ull. A combo PHY used between
>> USB Gen3 / PCIe Gen3 controller.
>> It is different from USB QMP PHYs.
> So we have now three different items called Qualcomm uniphy. Could you
> please add some distinctive name?
There is one more target called IPQ5018 which is also having similar USB 
PHY built on top of
Uniphy 28nm LP. That also can leverage this upcoming IPQ5332 USB PHY 
driver. Considering that,
given a common name 'uniphy'.

- Praveenkumar
>
>> - Praveenkumar
>>>>    maintainers:
>>>>      - Robert Marko <robert.marko@sartura.hr>
>>>> +  - Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> +
>>>> +description:
>>>> +  UNIPHY / COMBO PHY supports physical layer functionality for USB and PCIe on
>>>> +  Qualcomm chipsets.
>>>>
>>>>    properties:
>>>>      compatible:
>>>> --
>>>> 2.34.1
>>>>
>
>
