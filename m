Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3CF7E8052
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjKJSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343989AbjKJSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5556D3B30A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:43:15 -0800 (PST)
Date:   Fri, 10 Nov 2023 16:43:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699630994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDUnFWkz9m1SxE9OD5lKZxPMSGqq0UdgfhdcM17FYxo=;
        b=vkZfFS+R7cgzPfYqJuNwjKq9wqYq2u0qceq4PxqiGOIKdE+txAiuMik2u197ebPhX6XXvI
        ViKNmblxDV67K78kwHMwqneVn06W/juRP8ktaiBcuRdJcbkyV0kE8sSaUtJ9KcWynPss2d
        y298PIQEIDg9GehIgFFY193wHEqfIelRJZasgA5z42NDi4VrxvHWJ/e8OyWBn7HSVE8/7+
        wa94t+McqLCIj4sO2aVsUGphWjymdIg7Qc3AFSjEa85kyOTdmeltDXLCdyuY6L1Wa1jZHq
        VIXBRbllT7tS2HACexszNA9zWEzohfyC8cnxHvwtdaHzAp/FhnMWOgUZGIvyTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699630994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDUnFWkz9m1SxE9OD5lKZxPMSGqq0UdgfhdcM17FYxo=;
        b=cUuXo8IOBNYv/I8RjdhGiuLkvNyNJTQjE6jaGY9HtcCUGY4eD5OY/WmuwUm5b2KJTmTRBN
        MvF1c7Kcvfqcy9CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <20231110154312.1xjowQfg@linutronix.de>
References: <202311080409.LlOfTR3m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202311080409.LlOfTR3m-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-08 05:48:25 [+0800], kernel test robot wrote:
=E2=80=A6

Same report as in 20231110154208.5UoC_qsI@linutronix.de but for
different file. Don't see anything wrong.

Sebastian
