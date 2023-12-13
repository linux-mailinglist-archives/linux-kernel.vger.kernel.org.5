Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73188811778
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442147AbjLMPkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442356AbjLMPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:39:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E7A19F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:39:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64BDC433C7;
        Wed, 13 Dec 2023 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481993;
        bh=6AM6HzmzlNePc9eLi1v9b1TYKvgnhVKKi53VuhnmrQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k1PYCxW566zHq45yqBcmJpHK212X1cSreNhbOYZ7R/p2dAfWpatw3XDxiXEHxMxrk
         p2Dw1/2VTcgD9t1r6HgmUIdI8JKO3as8oUBdDAvr2jvz+bxL1QzrV4jZDIWaV9mjZW
         y6TSUygRnEh+5hsOCOLbF2dC1Rhzx3NlDY8XkJ+zRWM56MRmaVCcJUbHrPToRGByZ+
         VpLBXhx0oO9iOrBYidh0a+uKmyAdWIM4QBU9WuOSIS/fd1UCc2TQRbe9hxBcDDKU9C
         GCll0BOAZKtPqOa0whMH+6JUykPC3z7y6uSZ4RzOz3ExAwB2Gj+F6o317uEwP64djV
         NUgnogJ2lYjHw==
Date:   Wed, 13 Dec 2023 07:39:51 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [GIT PULL] Immutable branch between LEDs and NetDev due for the
 v6.8 merge window:wq
Message-ID: <20231213073951.4293c0c7@kernel.org>
In-Reply-To: <20231213130555.406aa2ef@dellmb>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
        <170142826116.3357002.9561246405642038358.b4-ty@kernel.org>
        <6577315e.050a0220.50f30.0122@mx.google.com>
        <20231211084656.26578d89@kernel.org>
        <657784f6.5d0a0220.617b5.20ee@mx.google.com>
        <20231211140546.5c39b819@kernel.org>
        <20231213112705.GI111411@google.com>
        <20231213130555.406aa2ef@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 13:05:55 +0100 Marek Beh=C3=BAn wrote:
> > No, please don't do that.  None of the branches I maintain are stable.

Nice, /me adds that to the notes.

> Please don't pull this. The sysfs documentation for the link_* files
> does not specify that they are available only if the underlying speeds
> are supported.

Roger that.
