Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC287803EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357309AbjHRCmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357295AbjHRCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:42:09 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FFA4273C;
        Thu, 17 Aug 2023 19:42:08 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D19C292009E; Fri, 18 Aug 2023 04:42:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CAD8192009B;
        Fri, 18 Aug 2023 03:42:07 +0100 (BST)
Date:   Fri, 18 Aug 2023 03:42:07 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 3/3] MIPS: Modify the declaration for die()
In-Reply-To: <1692005246-18399-4-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <alpine.DEB.2.21.2308180231330.8596@angie.orcam.me.uk>
References: <1692005246-18399-1-git-send-email-yangtiezhu@loongson.cn> <1692005246-18399-4-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023, Tiezhu Yang wrote:

> While at it, modify the die() declaration in ptrace.h to fix
> the following checkpatch warnings:

 It doesn't make sense to say: "While at it" now that it's a separate 
change, so how about:

"
Modify the die() declaration in ptrace.h to fix the following checkpatch 
warnings:
"

?

  Maciej
