Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64C7BB008
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjJFBTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJFBTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:19:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE87DE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 18:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+AiG5RcuIRXjXQBaPipww/shhwqPCseS7Zrsx9WocQ0=; b=BC0oYb8aTYOJBZjE50dd8NPPc7
        /73Cl4ZQ6jjJ90vlAM/EoJxzOd5H/w65Jl40qapwuCR4+7/CbkOci6f1rVTuM95HLFwef0uky/c0+
        TqDERrDka6zstklGFvad7asco2exJ0GDEqADstiBXwuKDeYpkc3b7KBBMGwoZcr0Nryib+rDoYbOw
        5QNF2BuRFcLhOqrspD4pB3oeCChYLLOlZXtGanexFxob6KrLb5WOyZck3ba9KYyauokJmgjcw59qE
        3T0nQGcdq19KhbJd+n5sX6HQYaySrZVymsSwsHO/i1UsiwQn2laYEA51/0V7wGYqXV0xWYwyVINtg
        unnCg4lw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qoZUn-00CWqH-Bv; Fri, 06 Oct 2023 01:19:13 +0000
Date:   Fri, 6 Oct 2023 02:19:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Erhard Furtner <erhard_f@mailbox.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bisected] PowerMac G5 fails booting kernel 6.6-rc3 (BUG: Unable
 to handle kernel data access at 0xfeffbb62ffec65fe)
Message-ID: <ZR9gkZKafUSNOAEf@casper.infradead.org>
References: <20230929132750.3cd98452@yea>
 <ZR9esG8H17LY2KOX@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR9esG8H17LY2KOX@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 08:11:12AM +0700, Bagas Sanjaya wrote:
> Matthew Wilcox, did you miss this regression report? You should look into it
> since it is (apparently) cause by a commit of yours.

No, I didn't miss it.  I'm simply choosing to work on other things.
All this regression tracking nonsense and being told to work on things
by people who've appointed themselves my manager has completely sapped
my motivation to work on bugs.  If you want me to work on things, *don't*
harass me.

