Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D9B77B553
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjHNJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjHNJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F9C195;
        Mon, 14 Aug 2023 02:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FFF562A49;
        Mon, 14 Aug 2023 09:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2874C433C8;
        Mon, 14 Aug 2023 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692004971;
        bh=I5eP7QwPtvi99/Ipxhh+MqvAiTYxlbBxBx8v4jcURgA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=upsMdRwvRgnNp7ubJI2arCWg6mKA1Jna0DV1ud11gydjbSNhjDKou/OVliA5W2MS/
         hNc9ewTPIWOnCMoyQT8nb/lqqyTqFanjuUL/1S67n/GtbegEwyvDtdp1i1vuFMV3pi
         YuLRWhtF8RMnvlbgMZwLZQOJwPTZFIQixbR2kEFPW3QMwJkF3riN/eRAM5X/MEOAz6
         dwS8C4S0Rk9A/0YNJQhOLMXue1HvqYH+nYPfRGgrwlLJa+st3SGFGrnLwwdJ3wbK41
         Vw5wDz7ZTzELXiB7NfKFNsTe+owZkxuoGoW9XYtK/ORMv5qTjOZm1gHziUmYnlyo1N
         +IDRFwaUCYweQ==
Date:   Mon, 14 Aug 2023 11:22:47 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Rename HID++ "internal" error
 constant
In-Reply-To: <20230620085014.542370-1-hadess@hadess.net>
Message-ID: <nycvar.YFH.7.76.2308141122410.14207@cbobk.fhfr.pm>
References: <20230620085014.542370-1-hadess@hadess.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023, Bastien Nocera wrote:

> As per the upstream "hidpp" helpers commit:
> "
> There has been some confusion about error value 5 but feature specs that
> refer to it generally use NOT_ALLOWED.
> "

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

