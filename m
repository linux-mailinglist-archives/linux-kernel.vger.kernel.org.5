Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A77729B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjHGPsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHGPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:48:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BADBD;
        Mon,  7 Aug 2023 08:47:59 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691423278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqjKSzzvOWgffO/YjJ00bdEjkbv7wETYrkAjCzgrrQU=;
        b=u+Ft7yP+ZPdVHZbxZYCnI6jjjEJz2ATsPLLTGoNOssuzCZEB1YYL48lFVVSTvM/4Yh+Cqc
        VOaFUtiA1IBjhxOJnmFDoUSYMTjRa8myLbHjUclKwdZJZAzJIWPhSBiFtbKM8s79m3Cc9O
        5+peoVJW14/EkXp+1wbHtaGpkfyjhsHugYetk7n4aZALLlfd45gbUhQbciElAIzmCi7i/o
        zEK/Es4dLRDbLJBTvzyvW1kg3EvD0bxCGCefIVup/xJNlI+0RjQuYLHdokWXDlZM5oSdm4
        4cHZy9nO0Aifi6Um8KcD+nA0e+fLTMpOrBWFVADxjT1uaEIfwutG30iTUOV0YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691423278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqjKSzzvOWgffO/YjJ00bdEjkbv7wETYrkAjCzgrrQU=;
        b=ZFdFnkHYFFdu2r+GmXVOvsqNpFVdRkka6/OjUJprFJucSoxNSHf7DNpqV4e0SessZf67Lz
        FxWPcmx/tXEMgWCg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: core-api/cpuhotplug: Fix state names
In-Reply-To: <87ttwd8f4e.ffs@tglx>
Message-ID: <427ee6f-61e3-e97e-195d-cee0bede2ceb@linutronix.de>
References: <20230515162038.62703-1-anna-maria@linutronix.de> <87ttwd8f4e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023, Thomas Gleixner wrote:

> On Mon, May 15 2023 at 18:20, Anna-Maria Behnsen wrote:
> 
> > Dynamic allocated hotplug states in documentation and comment above
> > cpuhp_state enum do not match the code. To not get confused by wrong
> > documentation, change to proper state names.
> >
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 

Ping?
