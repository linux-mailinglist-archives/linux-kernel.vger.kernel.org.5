Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F87F31E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjKUPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKUPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:05:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F159A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:05:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700579112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KjjRENyIIHRJHw26yA/5t0ZdiTjQTajwinD8UgZtW8=;
        b=Nne1UYYpO9YC4Jcq33W3qAoW7NW13yqL01mFIczivlJkV37Dhddfu9NIv51wwzg9Fk7Nal
        Vv34l37qbJlCO/VqrzSh+1wnCZb7yf+Oy3OsjnKxNiswWkpnkGhUQqZKN5qPpxBYB8Y6FT
        l6mgJN9wbaOMo0QE2ThBMmZaOL7qeHFuqELDJMa4i0+YQiXoPArF/cNZuwRWLvyWmD4M8f
        vmpaIiOZtlXYNHhsjImvXG/lPY2jwAvmGxE6vQHwuByiJQ8Og37ZqmnBzP+nOGZLIQFrW7
        7xoam5qz4nXB0gtiRPeK0lzRdqqYnbvAkr6i0JDkWI7j+65+0+8J+jBQTgoAvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700579112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KjjRENyIIHRJHw26yA/5t0ZdiTjQTajwinD8UgZtW8=;
        b=BBty8hjfHWW/6/OL4uJFgNpFlTmqGtEqY/8aF3vfhSgSJFnz4/GdDlL53K46mcD2fifLIp
        tu/Zd3lnpEX+mrAw==
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] x86/microcode: Unify early reporting
In-Reply-To: <20231115210212.9981-1-bp@alien8.de>
References: <20231115210212.9981-1-bp@alien8.de>
Date:   Tue, 21 Nov 2023 16:05:12 +0100
Message-ID: <87sf4z1713.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15 2023 at 22:02, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> microcode: Current revision: 0x0a201025
> microcode: Updated early from: 0x0a201016

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
