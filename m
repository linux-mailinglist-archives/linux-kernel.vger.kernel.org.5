Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203297BE215
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376619AbjJIOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346602AbjJIOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:06:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5053694
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:06:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696860369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yga3Q454HGo55CbU/e/YV1HmeDJRCKXDZhRdXG5J2rU=;
        b=J9XWkCPO+lB5Vm9ZtTN35v1Sd6gOY0InKjDFST/VCQxlfR/hUUigOJ6WqHWjYNyrdrlHXh
        Dp9kj2vmRhvIbfD1bUO13dc6WBgueE8KtahNtDJHEZ72A9eWJdyU3SK3dz/9uSGRnu4pzU
        I1Oo6wSV4KO/m2aQf0PvCromMgCphn12Uq/KFuNkwSUfUdzRpbIVn7R8Df5su8/LTjAW34
        VMXnn/RIfV2WLh7+a3plOWkyVEqrRDRGJnP6YLpU7Gr5E0N7v0xE8kNWFem8B7pZ0H9ui3
        h7bNQ5SB0rdhPQCRFRH5yMVju+J+ccWPhqDsSZU0pvN1l+dc4b7iJ7cnRLk2JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696860369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yga3Q454HGo55CbU/e/YV1HmeDJRCKXDZhRdXG5J2rU=;
        b=bRq/7OR+56006HsmGkWOKYM2RXhrpeariOEJ/ul3hSDG2ncbN6besv7Xu1AyC0H/9gFdpT
        0MhbZUBHBBpfYlBw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Remove myself from the general IRQ
 subsystem maintenance
In-Reply-To: <20231002141302.3409485-3-maz@kernel.org>
References: <20231002141302.3409485-1-maz@kernel.org>
 <20231002141302.3409485-3-maz@kernel.org>
Date:   Mon, 09 Oct 2023 16:06:08 +0200
Message-ID: <87ttqzq4a7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02 2023 at 15:13, Marc Zyngier wrote:
> It is pretty obvious that I haven't done much on the IRQ side
> for a while, and it is unlikely that I'll have more bandwidth
> for it any time soon. People keep sending me patches that
> I end-up reviewing in a cursory manner, which isn't great for
> anyone.
>
> So in everyone's interest, I'm removing myself from the list
> of maintainers and leave the irqchip and irqdomain subsystems
> in Thomas' capable hands.

Sigh. That's going into the wrong direction. I'm the one working towards
retirement!

Anyway, thanks a lot for all the work you were doing in the last couple
of years!

   Thomas
