Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB067CF33E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjJSIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJSIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:52:27 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38C989F;
        Thu, 19 Oct 2023 01:52:22 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qtOlP-0004JP-00; Thu, 19 Oct 2023 10:52:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9FB39C01CB; Thu, 19 Oct 2023 10:51:38 +0200 (CEST)
Date:   Thu, 19 Oct 2023 10:51:38 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] MIPS: lantic: Fix "no prototype" warning
Message-ID: <ZTDuGnjB9kSrMxge@alpha.franken.de>
References: <20231010143406.974591-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010143406.974591-1-helgaas@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:34:04AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix a "no prototype" warning found by the kernel test robot.
> 
> Bjorn Helgaas (2):
>   MIPS: lantic: Fix pcibios_plat_dev_init() "no previous prototype"
>     warning
>   MIPS: lantic: Remove unnecessary include of <linux/of_irq.h>
> 
>  arch/mips/pci/fixup-lantiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to mips-nextr. I've fixed lantic -> lantiq while applying.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
