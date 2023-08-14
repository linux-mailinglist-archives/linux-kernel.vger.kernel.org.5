Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377577B5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjHNJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjHNJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:47:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29D8D1;
        Mon, 14 Aug 2023 02:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490B164393;
        Mon, 14 Aug 2023 09:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBAFC433C7;
        Mon, 14 Aug 2023 09:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692006424;
        bh=ITyUf+LOPZiE5iOtagS/gKnXHqaxOrbvl0msY7L9C64=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OBctmUXpb9G0aTjXjhHJa3/H1G5qGA0u/XzlopOUF1xmcrbkRU0ibssAHIbYBw/ZJ
         8glljfGjiEbbyC+DLLIL4PX879CLsjTdD1Kz2FhAF4NZKMsoRISVw/ZagY3mGlU4/0
         6JxaQl6dBA6xr+5gPgVax+E4lfW1UJGZMsidWoTlw2oFHwOKJiHgRhnSfDk9MF9vuH
         dxcUKO3p17wm/pPuF/d4WliCLJ+32ggoejIE6xC8tkh7DHWtxHKPQtVMDk3RUbw6ie
         VC7oDE2wGxOdQvUYLW/V+DacfS73FgUHTkJNVU/ckXfb9m/DxcBNJY6HZh5+RMuJEh
         clPsT74awqbQw==
Date:   Mon, 14 Aug 2023 11:47:01 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
cc:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for Logitech MX Anywhere
 3 mouse
In-Reply-To: <20230809113832.123667-1-maxtram95@gmail.com>
Message-ID: <nycvar.YFH.7.76.2308141146540.14207@cbobk.fhfr.pm>
References: <20230809113832.123667-1-maxtram95@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023, Maxim Mikityanskiy wrote:

> Add Logitech MX Anywhere 3 connected over Bluetooth to the device table
> to get hidpi scroll supported. USB connection over the Unifying receiver
> is already supported by the wildcard entry LDJ_DEVICE(HID_ANY_ID).

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

