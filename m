Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A591F7A578F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjISCzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjISCzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:55:02 -0400
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7EF95;
        Mon, 18 Sep 2023 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
        s=mail; t=1695092095;
        bh=HchvUGBBFEqF4PByO8v4Sq08CusQeF0JV4G/0/i5bpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qx7sGoh2RzGd/ateids9qPmYhBFFvUFAFpLaZMYwxPGsRpPTcgFd3jw5Xrg3fLWNS
         SgF8hzVKti7EjgvQHabXAkdRKtayTekEWm4iPVkrc21VnlStCL9zULYmrI29Buia3f
         dJk/aB7Q2obUJsPkN5uduBd0iSPZmJhdus9NRDV7pGuJ0ZkwF1eYrDb9zN2gb6jQlL
         8WdXleFK9XOSBCa+TGJuVzEk1lRZsUYX91EGCGqCPp0WR2mkGs/AO2Gtqua5gntVfA
         O2LFkHIVZTs0y0mxgywGV4JNKIFAfkrIQNQ4ElK4qP0+SrWWu81u1MIy2xBvsBOSP9
         Ndwzv6Nudhzig==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by core.lopingdog.com (Postfix) with ESMTPSA id 446694402DB;
        Mon, 18 Sep 2023 21:54:54 -0500 (CDT)
Date:   Mon, 18 Sep 2023 21:54:52 -0500
From:   Jay Monkman <jtm@lopingdog.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>,
        Parthiban.Veerasooran@microchip.com
Subject: Re: [PATCH 4/4] net/onsemi: Add NCN26010 driver
Message-ID: <ZQkNfAOYgsBIhBRW@lopingdog.com>
References: <ZQf1QwNzK5jjOWk9@lopingdog.com>
 <6e19020f-10ff-429b-8df3-cad5e5624e01@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e19020f-10ff-429b-8df3-cad5e5624e01@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 06:00:37PM +0200, Andrew Lunn wrote:
> Is this an OA TC6 device?  At a quick look it does appear to
> be. Please make use of the framework Microchip is developing:
> 
> https://lore.kernel.org/netdev/20230908142919.14849-4-Parthiban.Veerasooran@microchip.com/T/

Yes it is. I wasn't aware of Microchip's work. Thanks for pointing it out.

