Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E07DCDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbjJaNOB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344460AbjJaNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:14:00 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF051DE;
        Tue, 31 Oct 2023 06:13:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8E16B6342D5C;
        Tue, 31 Oct 2023 14:13:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gyoZmDU2bVFp; Tue, 31 Oct 2023 14:13:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1AA2A6343CA2;
        Tue, 31 Oct 2023 14:13:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SqpRzGrHu0lP; Tue, 31 Oct 2023 14:13:53 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D73266342D5C;
        Tue, 31 Oct 2023 14:13:53 +0100 (CET)
Date:   Tue, 31 Oct 2023 14:13:53 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <440004449.28174.1698758033696.JavaMail.zimbra@nod.at>
In-Reply-To: <20231031134522.27e78274@xps-13>
References: <20231030103415.401ce804@canb.auug.org.au> <20231030173228.691620ca@xps-13> <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at> <20231031085158.o4ilb5d47sxcqm3o@quack3> <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at> <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner> <2131754563.27779.1698751840800.JavaMail.zimbra@nod.at> <20231031134522.27e78274@xps-13>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: manual merge of the mtd tree with the vfs-brauner tree
Thread-Index: t2uz7aNH9GoEU2quLgpVm8VgSIfvYg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> Miquel, we could also keep ff6abbe85634 in the mtd tree and explain Linus the
>> conflict, what do you think? That would help with back porting to stable.
> 
> It's not relevant if the patch in Brauner's tree is already fixing this
> up. Just send the smaller patch to stable@vger.kernel.org asking them to
> backport this patch instead of the other one, they are used to this
> kind of constraint, no?

I'm just in fear of stable rule #1.
"It or an equivalent fix must already exist in Linus' tree (upstream)."

Anyway, I'll try.

Thanks,
//richard
