Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8E77E771
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbjHPRQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbjHPRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:16:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCD2D48;
        Wed, 16 Aug 2023 10:16:13 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GCMFPf026499;
        Wed, 16 Aug 2023 17:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=zhkaB++sZDMq2yanj4e1JbYu42RN6uvd1pKF9zJHIZo=;
 b=JMP48rz/0Bzyzxpc1z//LFHnHF6VmQRM8qnKLyz//YLATs0DBCRAHGJxcWrT6zAvvBA1
 VGfk5cR5ltG7BnphZtYNl5VsHzHr0raLU8FARTtOrmcHWP2VuMBBZY2oEoXo/A5Q6OtU
 7WRJ/fXotoZcOrcP7xCiKc4xFzLeaKcuNi0lcSMlWZzxbod5ngBEjj1gD/TH22Kwk/w4
 naGacPbUc4U7HGhRMkWDJJF+eThXAOg/DkNDWudOHrWWV8PWqTQkfT1rnEPH6AdF/0+V
 LAR8aAl4VGIrf/wuNIn5JqWj4H/K1LtKIvi71AnKiV3MsML4E7c6C1YpIdN9rdv8pcM+ BA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sg83rbd0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:15:41 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GHFeIX002878
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:15:40 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 10:15:39 -0700
Date:   Wed, 16 Aug 2023 10:15:38 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Message-ID: <20230816171538.GB26279@quicinc.com>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <20230810185526.GC31860@quicinc.com>
 <4d94d0fd-72d4-0196-3a30-3e1efb9f5aca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4d94d0fd-72d4-0196-3a30-3e1efb9f5aca@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rlUvw-RXrUOWd5u-0bjWn0IL_MERk8Rr
X-Proofpoint-ORIG-GUID: rlUvw-RXrUOWd5u-0bjWn0IL_MERk8Rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_17,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=630
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments, Krzysztof.

On Aug 15 2023 23:06, Krzysztof Kozlowski wrote:
> On 10/08/2023 20:55, Guru Das Srinagesh wrote:
> > On Aug 03 2023 01:23, Guru Das Srinagesh wrote:
> >> When pushing patches to upstream, the `get_maintainer.pl` script is used to
> >> determine whom to send the patches to. Instead of having to manually process
> >> the output of the script, add a wrapper script to do that for you.
> >>
> >> The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
> >> editing it in-place.
> > 
> > Could I request reviews from the other maintainers as well, please? Just to see
> > if I should continue working on this script or if the `b4` tool obviates the
> > need for such a script.
> 
> I send a bit of patches but I use very simple workflow. It is really
> simple, so simple, that I was always surprised how people can make their
> life difficult with some complicated process to send patches... and then
> obviously skip some maintainers, because of that process.

Exactly - this script aims to solve precisely that problem. It fills the gap
between running `get_maintainers.pl` and having to manually edit its output to
add "To: " and "Cc: " and somehow incorporate it in the body of the patch(es).

With this script, the workflow would be as simple as:

  1. Generate patches using `git format-patch`
  2. Run `add-maintainer.py` on the above patches
  3. `git send-email` the patches.

That's it - no need to manually work with email addresses.
  
> I almost always feed git send-email with addresses from
> scripts/get_maintainers.pl. This tool would not bring any benefits to my
> simple workflow.

In the light of the 3-step workflow I've envisioned above, could you please
elaborate why not? If anything, it will only save a developer's time.

> For newcomers, OTOH, I would either recommend simple workflow or just
> use b4. Why? Because if you cannot use git-send-email, then it means
> your email setup will make your life difficult and adding maintainers to
> existing patch won't help you.

You've mentioned a "simple workflow" many times - could you please share more
details on the steps you follow in your workflow for sending patches?

> This tool depends on the command line and shell interface of
> scripts/get_maintainers.pl which is another reason why it might not be a
> good idea.

Could you please elaborate on why depending on the output of
`get_maintainer.pl` is a bad idea? It's what everyone uses, no?

Thank you.

Guru Das.
