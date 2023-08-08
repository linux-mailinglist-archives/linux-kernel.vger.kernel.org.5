Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F193773DFD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjHHQYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjHHQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:23:11 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D569EF3;
        Tue,  8 Aug 2023 08:49:38 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 57C369200C6; Tue,  8 Aug 2023 17:31:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4DBE59200C5;
        Tue,  8 Aug 2023 16:31:43 +0100 (BST)
Date:   Tue, 8 Aug 2023 16:31:43 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Yuan Tan <tanyuan@tinylab.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org
Subject: Re: [RFC 0/1] mips: malta: Select PCI_QUIRKS if POWER_RESET_PIIX4_POWEROFF
 is enabled
In-Reply-To: <cover.1690968173.git.tanyuan@tinylab.org>
Message-ID: <alpine.DEB.2.21.2308081628470.38537@angie.orcam.me.uk>
References: <cover.1690968173.git.tanyuan@tinylab.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023, Yuan Tan wrote:

> I just found that the on QEMU Malta, POWER_RESET_PIIX4_POWEROFF relay on
> PCI_QUIRKS to work, or else the reboot will hang.

 I'll check if it is reproducible with actual hardware, otherwise it might 
be an issue to fix in QEMU.

  Maciej
