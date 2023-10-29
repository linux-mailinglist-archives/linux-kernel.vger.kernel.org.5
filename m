Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948337DAD0A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjJ2Pjm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 29 Oct 2023 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2Pjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 11:39:41 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C31BD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 08:39:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BC2B7622F591;
        Sun, 29 Oct 2023 16:39:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NFBs-rp-B3AA; Sun, 29 Oct 2023 16:39:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5158B623488E;
        Sun, 29 Oct 2023 16:39:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zabHgERD03US; Sun, 29 Oct 2023 16:39:34 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 28FAE622F591;
        Sun, 29 Oct 2023 16:39:34 +0100 (CET)
Date:   Sun, 29 Oct 2023 16:39:33 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        dpervushin <dpervushin@embeddedalley.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Message-ID: <142222867.20038.1698593973984.JavaMail.zimbra@nod.at>
In-Reply-To: <20231029145033.0ad2682a@xps-13>
References: <20231027012033.50280-1-wangzhaolong1@huawei.com> <20231027194026.1bc32dfe@xps-13> <174426702.13324.1698438610904.JavaMail.zimbra@nod.at> <20231029145033.0ad2682a@xps-13>
Subject: Re: [PATCH v3] mtd: Fix gluebi NULL pointer dereference caused by
 ftl notifier
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix gluebi NULL pointer dereference caused by ftl notifier
Thread-Index: fvJCmV8fRlPNgwN6SsR/AdyXQB8pjw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> Ack. I'll queue this once the log fixed and your official Ack-by
> received for mtd/next after -rc1 is out.

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
