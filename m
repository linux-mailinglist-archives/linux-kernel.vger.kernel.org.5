Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF87DCFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbjJaOuV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbjJaOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:50:20 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B5F3;
        Tue, 31 Oct 2023 07:50:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AF6226342D5C;
        Tue, 31 Oct 2023 15:50:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FVsp3OUWLPeo; Tue, 31 Oct 2023 15:50:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 461546343CA5;
        Tue, 31 Oct 2023 15:50:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3l07tppJEt09; Tue, 31 Oct 2023 15:50:14 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1207F6342D5C;
        Tue, 31 Oct 2023 15:50:14 +0100 (CET)
Date:   Tue, 31 Oct 2023 15:50:13 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <111052022.28286.1698763813964.JavaMail.zimbra@nod.at>
In-Reply-To: <20231031154631.61e5f83e@xps-13>
References: <20231030103415.401ce804@canb.auug.org.au> <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner> <2131754563.27779.1698751840800.JavaMail.zimbra@nod.at> <20231031134522.27e78274@xps-13> <440004449.28174.1698758033696.JavaMail.zimbra@nod.at> <20231031145006.3df11822@xps-13> <20231031-trauben-jobben-40074a43e5a0@brauner> <20231031154631.61e5f83e@xps-13>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: manual merge of the mtd tree with the vfs-brauner tree
Thread-Index: kWPa0v3hfia+qBl27L6nOQ2p8bVm3g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> vfs-6.7.super was merged yesterday, if that's what this is about.
> 
> Great, thanks for the confirmation. Then Richard you have your upstream
> commit already!

Well, I'd like to back port ff6abbe85634, which is not upstream.
But I'll try to argue that ff6abbe85634 is the super simple variant of 1bcded92d938.

Thanks,
//richard
