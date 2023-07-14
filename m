Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA043754368
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjGNTr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjGNTr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:47:28 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6830C4;
        Fri, 14 Jul 2023 12:47:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 137EC5BF;
        Fri, 14 Jul 2023 19:47:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 137EC5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689364047; bh=fcxKLrTPkPPkHHCEgZFToadOZ/X7kwZd0OaqJLbDcS4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R9T8pEwunRRqvjH45vfoAQfbQf399f346HtJfL7TTC7RGJNfhtJtZBpy9zDARVo1U
         gvoQh8IwiR7vmQ2SzzhBehzda2Mt9PDrpri2YWw98kRQdT5QCjdDWHmp5yg6weMj4w
         mi5hJ5Mrez5WbrS9DdToVmnondinLstzlH7HpYH4vQkkwGx8YR6RtxQ04dUrsfMhkJ
         C6EhxnsZdE8LM0jqxI0VcwyFb3yRDncJm3jdMs1+OTFHNXyBnGZ/uzGXR92+17eVOw
         eUnb92gO4/NI47hRTRGhutRY43H2Nj1irvmPzSLpYtbMfTHw6yqXFhYieR/dBlRK55
         +BnlE1exQk9wQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] docs: time: make separate section for time and timers
In-Reply-To: <20230704052405.5089-1-rdunlap@infradead.org>
References: <20230704052405.5089-1-rdunlap@infradead.org>
Date:   Fri, 14 Jul 2023 13:47:26 -0600
Message-ID: <87mszyxokx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Give time & timer APIs their own section and begin adding
> entries to that section. Move hrtimers immediately after
> this new section so that they are all together.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/driver-api/basics.rst |   27 +++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

Series applied, thanks.

jon
