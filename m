Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF7B7B17C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjI1Jni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjI1Jng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:43:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F7D122
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:43:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695894214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axC/dw4Vq2ko+VvOs3bsTfzQCHtnH/kvzNJ7FktgJqA=;
        b=g/hyzp5Ig6oNj7wHGAmDi8dNINPiSJ0gXUwAMC0k8GJuoy5y9soKn8tlbOT43hZarK9q/8
        CZyVpqt73xEW4MySgaEmB4tu63a9d0H3m0puKh0nA8gF3d8zNEIpgmXcfWX82aDxZgwdYW
        GlF+hhCNQoT4J83xCSkp8x0Hi1C5zSHSL0vHSJwTzzwGt/szUF2Is0nWgn/JPmkaqhUgXs
        9XWlEmHqfqfqiKWxAKiy6xrsJKnTbqwpNoWCkaHcAppm0zGbuhG+qEjuqof7i/FTRkwtJ3
        MDG22EhlTf9owrOrEFO/Ar0LSKAnz1EDn7RvoDGBD3A/S57mspCCDdGVvG3bJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695894214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axC/dw4Vq2ko+VvOs3bsTfzQCHtnH/kvzNJ7FktgJqA=;
        b=6A5iOOYJmA7gXhC0+y9DanFEedZZLeUAGgBFGympux51VdAB71woXwbZwiP4tfBIZAF+Q7
        WEMD/ZwcrXRZzrBA==
To:     liming.wu@jaguarmicro.com, linux-kernel@vger.kernel.org
Cc:     Liming Wu <liming.wu@jaguarmicro.com>
Subject: Re: [PATCH] genirq/debugfs: Fix a typo of irq debugfs
In-Reply-To: <20230927022925.751-1-liming.wu@jaguarmicro.com>
References: <20230927022925.751-1-liming.wu@jaguarmicro.com>
Date:   Thu, 28 Sep 2023 11:43:33 +0200
Message-ID: <875y3ufxa2.ffs@tglx>
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

On Wed, Sep 27 2023 at 10:29, liming wu wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Correct the spelling of effective.

That spelling is on purpose to have tabular output, which you break with
that change.

