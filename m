Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A3766159
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjG1Bfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjG1Bfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:35:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159853584;
        Thu, 27 Jul 2023 18:35:52 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S0Ax8X020676;
        Fri, 28 Jul 2023 01:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y/2Bw/kAq2TKluJ/8QoQW11LwTmBQFzoZPq4H3xFg3k=;
 b=CZuXxSF7/IGLf+C1NWwHwnFVlf10QGVv/gLFnYKfjsgABcnX776JjPpDzWq7ykaaqdZz
 1ihjDF03QIQN8v0m2XfwVKlHeQaCzO8eeeAF0UTr4ss4/BrRyROKGhL07w1f8VEogb1x
 Ks7pJuzN+7XGyVedcTojeuPtbGRjJGi0XQ0+NY1w2MqOCmDaDPsdl3J9E8EqlLsHfpfq
 mOe4SzbOtBNc0/AT3Umz7IGjmTvVuvj7DxaZA+Uy0lenYTaZqYSevlT5WFO17+VRXZa9
 j/PfAoxIaIg+KDlS627sEfBWddVq6Jwu1zeJKGWBQqggBXwjM436OGMJucA7KqQ59Gqz +Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s416m8887-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 01:35:45 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S1ZLfL030189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 01:35:21 GMT
Received: from [10.110.109.223] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 18:35:21 -0700
Message-ID: <05c31202-6081-1a27-1c80-57c710afa1a5@quicinc.com>
Date:   Thu, 27 Jul 2023 18:35:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] firmware: qcom_scm: Add missing extern specifier
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com>
 <bce25c8e215f7cfc7b0780d6965d09f5efe1cc5f.1690503893.git.quic_gurus@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <bce25c8e215f7cfc7b0780d6965d09f5efe1cc5f.1690503893.git.quic_gurus@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sVK9TCXILmKF46jm0_xiAF1uZbNBfIg-
X-Proofpoint-ORIG-GUID: sVK9TCXILmKF46jm0_xiAF1uZbNBfIg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=868
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280013
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2023 5:42 PM, Guru Das Srinagesh wrote:
> Commit 3a99f121fe0b ("firmware: qcom: scm: Introduce pas_metadata
> context") left out the `extern` specifier for the API it introduced, so
> add it.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---

This patch doesn't depend on the EXPORT_SYMBOL_GPL patch right? It can 
sent separately as well, but looks ok to me.

-- 
---Trilok Soni

