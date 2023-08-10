Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571777780C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjHJSun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjHJSuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:50:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30B26B8;
        Thu, 10 Aug 2023 11:50:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AHBeer007323;
        Thu, 10 Aug 2023 18:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=0oAA/Wwk5F+zzqVqMSJUPKdW/mN5W/7zEhwMKEdsQyE=;
 b=XKiH+xPJ1gyOX6d67dEJhyNYgHjxZOFzZhaZE8ed51ZohP5zQYNhIDTVSg1aq0/2usz8
 AMoHzM3ywYlRZCeOOoIfhunFKjX9vEjP5dgcl7I6cu80MrRoYdDUn8N7YWm3yOmDAMo4
 jTnYdQ2RpWH/yrjjhYGwPkuNZlZVroXoS7k81rn/7fYaiTC2i8kmcbWcszu9MeGhwR5G
 lM+mQcj6XunRTMzMh9fjmaNykX0xXKo+ASfR2BkizIa5ocujFG24+Xo/U5zt8CPJvrPz
 9HuWONvfsxoozsbUO4q3w0vQ+gBPRko/MTdl/q80Uf5tUJYPnoKRrvJ77hG1RyokVcY/ cw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scxfjh6nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:49:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AInfOE024516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:49:41 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 11:49:40 -0700
Date:   Thu, 10 Aug 2023 11:49:39 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
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
Message-ID: <20230810184939.GA31860@quicinc.com>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <27b8f21c-f705-ba65-5b2e-912fb97a85a9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <27b8f21c-f705-ba65-5b2e-912fb97a85a9@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1a85RmC-BuywvzAVejE_HhJ7bBqYz9vg
X-Proofpoint-ORIG-GUID: 1a85RmC-BuywvzAVejE_HhJ7bBqYz9vg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=444
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 03 2023 11:16, Neil Armstrong wrote:
> Hi,
> 
> On 03/08/2023 10:23, Guru Das Srinagesh wrote:
> >When pushing patches to upstream, the `get_maintainer.pl` script is used to
> >determine whom to send the patches to. Instead of having to manually process
> >the output of the script, add a wrapper script to do that for you.
> >
> >The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
> >editing it in-place.
> 
> FYI the b4 prep command does this:
> https://github.com/mricon/b4/blob/e8045d1353165cc065b2f1b180bf1b0846af510e/b4/ez.py#L2055
> 
> Perhaps it could be useful to make sure the output is similar ?
> 
> So far I've been very satisfied by the output of b4 auto_to_cc.

Thank you - let me check this tool out.

Guru Das.
