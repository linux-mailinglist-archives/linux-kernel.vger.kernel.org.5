Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FBE7B5D01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjJBWGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJBWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:06:39 -0400
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1A0B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:06:36 -0700 (PDT)
Date:   Mon, 2 Oct 2023 15:06:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696284394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEY9SxAIE8pwzuAQoIBCO5YWA98xQxOlqIWFVS/2M1I=;
        b=Vvr2iKAkPzZQLD9VqcfIlV0sg3xjtI4K8hu+bxCUYvnmd6j0nT4AhTOn0CS6YsuhCA0gmf
        +IH8GSi36LjjcWG1PBLR571DZ9H87slWd9OW+XlWLg3wqhg4ojgsKH6aMk3s8QFtPRgnUa
        hIabfPn7qrEIloMozagpH56qAJj51xU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mm tree
Message-ID: <ZRs-5gMPrpzONDEQ@P9FQF9L96D>
References: <20231003075522.0284d2b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003075522.0284d2b1@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 07:55:22AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   e47f255f6365 ("mm-kmem-add-direct-objcg-pointer-to-task_struct-fix")
> 
> is missing a Signed-off-by from its author.

Hi Stephen,

this commit is a fixup which will be merged into the main commit before
the final merge.

Thank you!
