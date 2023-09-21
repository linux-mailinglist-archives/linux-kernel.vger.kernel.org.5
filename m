Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1B27A98DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjIURx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjIURxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:53:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C937AF78;
        Thu, 21 Sep 2023 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+HobwbyhRrL+DiXWq60cCXmq0rRh6Myw3iz3VvCnh1Q=; b=ANHfhAIbaIS5IlcKDZ3DCQU3ew
        ZjjThTQm43SxXnljgJR34XhuheNewSfW9afdLy9gSgNGZKcplc3/I7/T1IqjlStPMOvPHv4WsNm1/
        c6YyKradLp5SG8uTQD4J9x00hOxYkHvIVLtk3JSPwFKSq5ySEp+pZESCPLGQBrJH7J5eIP/GhDz8T
        1ilB2ROeoYbroMSSoRhMOeJXYNBGZpSgjJh3pzTHRkhCyRC5RuwL1H2waNgPKh5WJwlzvVNBPtXq6
        pnqo3BSBqa0JUcGDm3hTu/hRAd11i6oU2S56j08ho2IrTqAGMwcqvEIeVgnwTF+nbhZ+w2ewBR6zi
        KuyDdgFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjE5l-00FCMX-1g;
        Thu, 21 Sep 2023 07:27:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2BC93002E3; Thu, 21 Sep 2023 09:27:18 +0200 (CEST)
Date:   Thu, 21 Sep 2023 09:27:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Fangrui Song <maskray@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: Re: [tip: objtool/core] x86/speculation, objtool: Use absolute
 relocations for annotations
Message-ID: <20230921072718.GB14803@noisy.programming.kicks-ass.net>
References: <20230920001728.1439947-1-maskray@google.com>
 <169528034747.27769.14777306686927534953.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169528034747.27769.14777306686927534953.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 07:12:27AM -0000, tip-bot2 for Fangrui Song wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     0ca0043d89930cb162070598e7e4a9ed3fe57795
> Gitweb:        https://git.kernel.org/tip/0ca0043d89930cb162070598e7e4a9ed3fe57795
> Author:        Fangrui Song <maskray@google.com>
> AuthorDate:    Tue, 19 Sep 2023 17:17:28 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 21 Sep 2023 08:42:38 +02:00

Ingo, can we please make this patch go away until further clarified?
