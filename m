Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B228C80C50B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjLKJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjLKJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:44:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F9BE8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:44:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFCFC433CA;
        Mon, 11 Dec 2023 09:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702287893;
        bh=Zh+N54AyVbzKOvWwPV9/di4kTKjV/K1n2+07OBQhpBM=;
        h=From:To:Cc:Subject:Date:From;
        b=WB5fzWkRKoYZYYqm0wX8nlkZt5boUyV9mneQaq3qymat33DiUq5ZNvtq2Ur/xQ5kT
         toKTAL/1KQxAojpvPoiMpal8O5OIRpoDmktzfNdtf0R8hb7PSiGCycCWXq6pSSpsC/
         AbnsyvMSIUfUpfFoMASLJ4O5tJ8wkkd0ut9B006g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.67
Date:   Mon, 11 Dec 2023 10:44:46 +0100
Message-ID: <2023121147-finally-museum-8aad@gregkh>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.67 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile               |    2 -
 net/wireless/core.h    |    1 
 net/wireless/nl80211.c |   50 ++++++++++++++++++-------------------------------
 3 files changed, 20 insertions(+), 33 deletions(-)

Greg Kroah-Hartman (2):
      Revert "wifi: cfg80211: fix CQM for non-range use"
      Linux 6.1.67

