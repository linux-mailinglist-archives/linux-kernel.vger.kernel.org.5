Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229F57813E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379845AbjHRTvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379900AbjHRTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:51:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED23421D;
        Fri, 18 Aug 2023 12:51:04 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IJNs00010954;
        Fri, 18 Aug 2023 19:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=t60leTcbjDGFV5UGb9QQpQ6GA3RU4VKVhGgVXZsRhZY=;
 b=EK8aDUEHyH49B0LIfbqaril+2/lLNc6JrnUHaAALIPPeitLwvGFG81WpyjqJ7xUKvlGg
 OeUIqzkMQk+FuDlTTabK17wRhVIlNyifgyU9BqmkiGHFETSDsTjE1WLyBx0OaoDroTzK
 VrBKi28bamg0YduJkM8ovo/aBzOOjvt7U9Fhj0Bth4mvfIbQ7tWigSpPwNcmDCJWic2E
 D68ZkgzbPEKq/10dvuN3uv8YiFQvpsmGbGsAcsNyyyy8+lzJB5B7RolC9xqYe69X8seJ
 QygZEjIjvaQKFqd3vdrSPlUI5GyBEBBxRv1p1MHoCkfRgcwK7FywbDD6wnFsea6bEucb 4w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sj1xdhmev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:46:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37IJkBk1001093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:46:11 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 18 Aug 2023 12:46:10 -0700
Date:   Fri, 18 Aug 2023 12:46:09 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Kees Cook" <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Message-ID: <20230818194609.GA1428172@hu-bjorande-lv.qualcomm.com>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <20230810185526.GC31860@quicinc.com>
 <4d94d0fd-72d4-0196-3a30-3e1efb9f5aca@linaro.org>
 <20230816171538.GB26279@quicinc.com>
 <6fb1176f-90f1-7a65-3ab5-f6447418c51e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6fb1176f-90f1-7a65-3ab5-f6447418c51e@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mCKM9W240SK9_B3lu8J6AiY1G4FmbXx8
X-Proofpoint-ORIG-GUID: mCKM9W240SK9_B3lu8J6AiY1G4FmbXx8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_24,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=529
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:43:31AM +0200, Krzysztof Kozlowski wrote:
> On 16/08/2023 19:15, Guru Das Srinagesh wrote:
> > Thanks for the comments, Krzysztof.
> > 
> > On Aug 15 2023 23:06, Krzysztof Kozlowski wrote:
> >> On 10/08/2023 20:55, Guru Das Srinagesh wrote:
> >>> On Aug 03 2023 01:23, Guru Das Srinagesh wrote:
> >>>> When pushing patches to upstream, the `get_maintainer.pl` script is used to
> >>>> determine whom to send the patches to. Instead of having to manually process
> >>>> the output of the script, add a wrapper script to do that for you.
> >>>>
> >>>> The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
> >>>> editing it in-place.
> >>>
> >>> Could I request reviews from the other maintainers as well, please? Just to see
> >>> if I should continue working on this script or if the `b4` tool obviates the
> >>> need for such a script.
> >>
> >> I send a bit of patches but I use very simple workflow. It is really
> >> simple, so simple, that I was always surprised how people can make their
> >> life difficult with some complicated process to send patches... and then
> >> obviously skip some maintainers, because of that process.
> > 
> > Exactly - this script aims to solve precisely that problem. It fills the gap
> > between running `get_maintainers.pl` and having to manually edit its output to
> > add "To: " and "Cc: " and somehow incorporate it in the body of the patch(es).
> 
> Why would anyone need to manually update it? Just some simple bash
> function or git send-email identity.
> 

I do this all the time, either to add additional, or remove unnecessary,
recipients from what's provided by get_maintainers.pl.

> > 
> > With this script, the workflow would be as simple as:
> > 
> >   1. Generate patches using `git format-patch`
> >   2. Run `add-maintainer.py` on the above patches
> >   3. `git send-email` the patches.
> 
> So one more unnecessary step (2). I don't think it is easier than my
> workflow.
> 
> I just do only 1 and 3 and that's it. The simplest way ever.
> 

There's no get_maintainer.pl in either 1, or 3, so obviously this isn't
the only thing you do.

Thanks for the link to your alias below, it's now clear that you don't
need an extra step in the procedure, if you only have your extra wrapper
around step 3.


I now also understand why you never ever have a cover-letter, something
Guru's proposed flow handles quite nicely.


That said, b4 prep and b4 send seems like a better suggestion to those
who doesn't already have a workflow in place.

[..]
> > 
> >> This tool depends on the command line and shell interface of
> >> scripts/get_maintainers.pl which is another reason why it might not be a
> >> good idea.
> > 
> > Could you please elaborate on why depending on the output of
> > `get_maintainer.pl` is a bad idea? It's what everyone uses, no?
> 
> No, because if interface changes you need to update two tools.
> 

This is a valid objection, but I've heard that "the simplest way ever"
also depends on exactly this output...

Regards,
Bjorn
