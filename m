Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F957F15B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjKTOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjKTOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:30:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2108136;
        Mon, 20 Nov 2023 06:30:42 -0800 (PST)
Date:   Mon, 20 Nov 2023 15:30:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700490640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzHlHnI4SFnhkGX3Kin1WzRbq9IYRqP2MnYzoUAaEKI=;
        b=n+fIfGfZPUT6M5QKQE1AvyjiYdgDNROHEOMoqYVQDqSWlTVGf8c+hCpeEvPYQII+vROy4H
        UCyUspWnYDhs9jAJ/DQMOf6IBTBOKik1VbqvPkHmVDEnaYoy0RGKuh10rnf9PKibhjdhOI
        x0dImiE3CAYVImJ+UFNHNVOaj6VXNn4+OYAC15zPQTF0kY1jOlnGHLNUMklqbpPJaiDkq+
        hUbp0NgPh38H/91Jsa/HFM/1WW9tkqKVgZdBppc7p6xPsHikXqIz8UGnUc8CoSBH+hP/hL
        aNMTt2xuaLKvKcRpoeD23+xM9NGgiBU5+8Dvi12zlnSLrT5F8uKM2Fx2vKo0xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700490640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzHlHnI4SFnhkGX3Kin1WzRbq9IYRqP2MnYzoUAaEKI=;
        b=5/kzGng8ya+jY75vHP7fb2OixYhDJ/zjc6Q5INIdUJ9WDiHs3wHPTRiI53zK5Gz41N9VVi
        Ucst14fkHxRZ5rAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [rt-devel:linux-6.6.y-rt] [printk]  78f4b59c6f:
 BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code
Message-ID: <20231120143039.HvK0o_uj@linutronix.de>
References: <202311161555.3ee16fc9-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202311161555.3ee16fc9-oliver.sang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-16 15:43:38 [+0800], kernel test robot wrote:
> Hello,
Hi,

> kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code" on:
> 
> commit: 78f4b59c6faa7afe24b973210151d4a82b5669eb ("printk: Update the printk series.")
> https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-6.6.y-rt

as in the previous report, it is the 32bit printk issue. Will be fixed
in next update.
Thank you.

Sebastian
