Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF367EB996
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjKNWuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjKNWuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:50:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F68BC1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:50:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9F8C433C7;
        Tue, 14 Nov 2023 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700002215;
        bh=K5UdBgRR6Qec7iBT61wqyndqMtZJrpxGixTMDhhacvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WQG7WK4gQLfG7P1HGhXD0kTl+Lehta0/BhAKcolxERvWkVLzure3V+27/f4z6tVhN
         8o0xoiHCmLZdrK3SnwG3CbXanHSMpGgsPpnIBz0sDz2VjkeWuhyPvBhxHVss06+Diw
         gDSZWoO7ZR7ZPchTfKXEXFFaYe0yPQVe7y0B1ofvQNwbEAC+bnGNQS1PIkaKA3BqQj
         R1/ARCFivSuBizzrGMcj3kMoEWCOofdfSuuufy66PBQiz1KjKGO69E//X2GUSzmvlb
         gJEcaHHDpC+2MU1vOwgQ3X7O16ezwlSf2lMzfURBj9c9qbq0c9cuX8uWjQBlN3IkUX
         ACOhf8bZ4RuFg==
Date:   Tue, 14 Nov 2023 17:50:13 -0500
From:   Jakub Kicinski <kuba@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add entry for TI ICSSG Ethernet driver
Message-ID: <20231114175013.3ab9b056@kernel.org>
In-Reply-To: <20231113094656.3939317-1-danishanwar@ti.com>
References: <20231113094656.3939317-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 15:16:56 +0530 MD Danish Anwar wrote:
> Also add Roger and myself as maintainer.

> +TI ICSSG ETHERNET DRIVER (ICSSG)
> +R:	MD Danish Anwar <danishanwar@ti.com>
> +R:	Roger Quadros <rogerq@kernel.org>

Looks like this got (silently?) merged already, but you added
yourselves as R:eviewers not M:aintainers..
