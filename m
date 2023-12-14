Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478E18137BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444055AbjLNRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjLNRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:11:22 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA0D1A1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:11:26 -0800 (PST)
Date:   Thu, 14 Dec 2023 17:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702573885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z7KQyebLnTixJI+7HeEOxa3aIwOhIUy62//tcXLarcA=;
        b=eQO/oAZcgvq6R0r3lvE7/mtXOn8K/LZeYyr5WruA3hOZyK6lKh34CkDmm2beyE4oHY3uEs
        j+sKJRhrezWPn9lH4JrmhgS/8+AmJbgnhEMkW/+pzhR+8mMBAUYCPnvPG+DdJ3VtgYJj4k
        whPLSPId+LYxelegpcceWypPhGccd1Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Isaku Yamahata <isaku.yamahata@linux.intel.com>,
        David Matlack <dmatlack@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>, Marc Zyngier <maz@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [ANNOUNCE / RFC] PUCK Future Topics
Message-ID: <ZXs3OASFnic62LL6@linux.dev>
References: <20231214001753.779022-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214001753.779022-1-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:17:53PM -0800, Sean Christopherson wrote:
> Hi all!  There are a handful of PUCK topics that I want to get scheduled, and
> would like your help/input in confirming attendance to ensure we reach critical
> mass.
> 
> If you are on the Cc, please confirm that you are willing and able to attend
> PUCK on the proposed/tentative date for any topics tagged with your name.  Or
> if you simply don't want to attend, I suppose that's a valid answer too. :-)
> 
> If you are not on the Cc but want to ensure that you can be present for a given
> topic, please speak up asap if you have a conflict.  I will do my best to
> accomodate everyone's schedules, and the more warning I get the easier that will
> be.
> 
> Note, the proposed schedule is largely arbitrary, I am not wedded to any
> particular order.  The only known conflict at this time is the guest_memfd()
> post-copy discussion can't land on Jan 10th.
> 
> Thanks!
> 
> 
> 2024.01.03 - Post-copy for guest_memfd()
>     Needs: David M, Paolo, Peter Xu, James, Oliver, Aaron
> 
> 2024.01.10 - Unified uAPI for protected VMs
>     Needs: Paolo, Isaku, Mike R
> 
> 2024.01.17 - Memtypes for non-coherent MDA
>     Needs: Paolo, Yan, Oliver, Marc, more ARM folks?

Can we move this one? I'm traveling 01.08-01.16 and really don't want
to miss this due to jetlag or travel delays.

-- 
Thanks,
Oliver
