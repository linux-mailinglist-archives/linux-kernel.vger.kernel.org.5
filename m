Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A007FE48A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbjK3AIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjK3AIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:08:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A398CA;
        Wed, 29 Nov 2023 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wC19h+a3SOXnMlcxcKFTeYkYqqhAvvzZkJugU6d0S84=; b=FYYKvnph70Iss01gIM6NbLHJEI
        hLAUiYhZVdtrj329KQeDedOO5hGPXhr84CO6gCLbyJJBnq3zAXWz4X1ZB5hb0qWp30XrCxyZQrWNs
        /v8hGKGBGj+EqWqJ5pnEKSAP6MndTRJ4IrgfNjgNQ36b7TELUNRWIt1Fcsgn29KzqJZTFbfZs+I4r
        H/yHas9OpQAins9j5FMBQZCz6NE/1v4OpX0zvIvbH3L7aLgeeZWCLiOFrzT5drMCIftpxE+LQntnw
        eOuKak7cdQODlKCfdErCu5WstO4CIgUHDypoHSo/6Baoz/nmoua+bCGWmFZ2LbENXVmam2JceK9uh
        6pKlKkOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8UbZ-00DtE6-M9; Thu, 30 Nov 2023 00:08:33 +0000
Date:   Thu, 30 Nov 2023 00:08:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Attreyee Mukherjee <tintinm2017@gmail.com>
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
Message-ID: <ZWfSgfiT/K6bTx7l@casper.infradead.org>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
 <ac7a90a7-4d29-059b-fbff-6b67e6f5c2d3@redhat.com>
 <a4da77c2-7a23-4988-b65a-a58c105d89a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4da77c2-7a23-4988-b65a-a58c105d89a4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:58:16AM +0700, Bagas Sanjaya wrote:
> I do this posting because I thought the OP (Attreyee) didn't respond in
> timely manner (just like random Chinese contributors like @cdjrlc.com
> and @208suo.com people).

That's a ridiculous excuse.  The original posting was two days ago!
If it had been a week since we last heard from Attreyee, I'd understand.
