Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CA80F68E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377166AbjLLTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376765AbjLLTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:22:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0177E9F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:23:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B20C433C8;
        Tue, 12 Dec 2023 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408980;
        bh=h0vdMWDI9l3i/aCuABJALbqVOeIG/b5avLtu1EGcQGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=geZ412zgATKQGgmDbqAHiOBD4pvlrFl6nusNREosZOaj6307z4fTb3QkXB8e3sudE
         p+hBXdmN3BwxqMPzrT0/VhUrr8AWvRGb4FN6NSZ4AFXN2wR717xJRkAo6Zef5Pz5Hr
         cZg2O3ev1lPyIuHoLwfasv5g11XtCtQiSt658sM3U1FvJPoGcfwT7Dq/P4tFymrszw
         OawWE6Dfh6M8UH1MYtHM+PhqmTNXUTjZ6AjTPFgeqXLQr4qdI/U41R9bhvKOddxPK4
         ZIGBXlEI766hkyBOG1ilGYyLC6nnfUdciT6SP4TAHUBeiYbMNz+KeIX64nEv0YQmzZ
         nVjTqxWneaV9w==
Date:   Tue, 12 Dec 2023 11:22:59 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Message-ID: <20231212112259.658d3a79@kernel.org>
In-Reply-To: <20231208094733.1671296-14-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-14-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 17:47:33 +0800 Justin Lai wrote:
> Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.

Sorry if I already said this but please familiarize yourself with the
responsibilities per:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
