Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B2F7CFE15
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbjJSPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346030AbjJSPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:39:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C383124;
        Thu, 19 Oct 2023 08:38:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907D1C433CA;
        Thu, 19 Oct 2023 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697729939;
        bh=AREkZrmSccQRuZ4xGIzEq28d+dMWO3ytqI01nPqGsxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYBi5Ia4cNzwlQhZHuxcog/XnJeh+GxvXj3dDk7kRzJ545iYDy0kSx0QGHXiUuz9f
         8M7ojGLcm1HjqBDTsaffw3GAYXKBaczOF1RGbSjqGMgks59s9Nj4Wx1jdRPMtdDFpR
         DdSO0z4pBuRnNKlSMUjDKY22rosC2Cj5KT1NJ3QA=
Date:   Thu, 19 Oct 2023 17:38:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TTY LAYER AND SERIAL DRIVERS" 
        <linux-serial@vger.kernel.org>, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH 1/1] tty: i3c: add tty over i3c master support
Message-ID: <2023101906-rimmed-unmarked-0ba2@gregkh>
References: <20231018211111.3437929-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018211111.3437929-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 05:11:09PM -0400, Frank Li wrote:
> Add new driver to allow tty over i3c master.

As Jiri said, you need a lot more description here before we can even
start to review it.

Please fix up and send a v2.

thanks,

greg k-h
