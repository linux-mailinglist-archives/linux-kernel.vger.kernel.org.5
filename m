Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A547E62E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjKIEn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjKIEnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:43:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A102584
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 20:43:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2561C433C7;
        Thu,  9 Nov 2023 04:43:18 +0000 (UTC)
Date:   Wed, 8 Nov 2023 23:43:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>
Subject: Re: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Message-ID: <20231108234322.31980c5f@gandalf.local.home>
In-Reply-To: <ZUxd66gHq+eoeSih@gondor.apana.org.au>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-15-ankur.a.arora@oracle.com>
        <ZUtRn7oJLL5fisco@gondor.apana.org.au>
        <20231108100818.4bc238e7@gandalf.local.home>
        <ZUxd66gHq+eoeSih@gondor.apana.org.au>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 12:19:55 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Wed, Nov 08, 2023 at 10:08:18AM -0500, Steven Rostedt wrote:
> >
> > A "Nack" with no commentary is completely useless and borderline offensive.  
> 
> Well you just sent me an email out of the blue, with zero context
> about what you were doing, and you're complaining to me about giving
> your a curt response?

First, I didn't send the email, and your "Nack" wasn't directed at me.

Second, with lore and lei, it's trivial today to find the cover letter from
the message id. But I get it. It's annoying when you have to do that.

> 
> > What is your rationale for the Nack?  
> 
> Next time perhaps consider sending the cover letter and the important
> patches to everyone rather than the mailing list.

Then that is how you should have responded. I see other maintainers respond
as such. A "Nack" is still meaningless. You could have responded with:

 "What is this? And why are you doing it?"

Which is a much better and a more meaningful response than a "Nack".

> 
> > The cond_resched() is going away if the patches earlier in the series gets
> > implemented. So either it is removed from your code, or it will become a
> > nop, and just wasting bits in the source tree. Your choice.  
> 
> This is exactly what I should have received.

Which is why I replied, as the original email author is still new at this,
but is learning.

-- Steve

