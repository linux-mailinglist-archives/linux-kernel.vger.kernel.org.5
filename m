Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CED7780DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjHJSzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHJSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:55:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C792926A6;
        Thu, 10 Aug 2023 11:55:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AEa5lj027034;
        Thu, 10 Aug 2023 18:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=0tvQRhrdWb6wzmsaExAY1CRBg2q30015lhUCm1C7fvs=;
 b=cDsiRw8UgmcoFt5i3bTiM5B/bQyMpNLToehp4M8SVVJqWkiPa7JP1KT5SSTYnSD9my2P
 nvg3y/D4absrG5ppRiHxgGOzVqZoogytsTyZvPeZwkrVzcaSLiG26cJtLo3RIJk5uh0V
 qu6s7vFNueQeoT37f6fEPEDHK0GZXm0aPXuHaaYLigRQtbOuAHXUCMhdZKOtU/a2DgH7
 yC6++wugcTzx4GuAdjqqUiB6wDU3ZhfSEuW3Mr7ZPhKV05HL+aJ2ayBet277ejCe8jHP
 dZUWx69tBLKwyF/7sbstQtdPNB/dUAObAYd7vJ8xboYZ7KnXX9JoeNvZJtjgLcOyba0M 8Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scr39j10n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:55:29 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AItSOZ017625
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:55:28 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 11:55:27 -0700
Date:   Thu, 10 Aug 2023 11:55:26 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Message-ID: <20230810185526.GC31860@quicinc.com>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1691049436.git.quic_gurus@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Eg4y66M8neM8Q4wg0N1zc16QfWy2Liy2
X-Proofpoint-ORIG-GUID: Eg4y66M8neM8Q4wg0N1zc16QfWy2Liy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=405 clxscore=1015 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 03 2023 01:23, Guru Das Srinagesh wrote:
> When pushing patches to upstream, the `get_maintainer.pl` script is used to
> determine whom to send the patches to. Instead of having to manually process
> the output of the script, add a wrapper script to do that for you.
> 
> The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
> editing it in-place.

Could I request reviews from the other maintainers as well, please? Just to see
if I should continue working on this script or if the `b4` tool obviates the
need for such a script.

Thank you.

Guru Das.
