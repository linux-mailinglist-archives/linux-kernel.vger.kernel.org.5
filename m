Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0577B598
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjHNJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjHNJgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C704BE73;
        Mon, 14 Aug 2023 02:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6544663EEA;
        Mon, 14 Aug 2023 09:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5D3C43395;
        Mon, 14 Aug 2023 09:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692005760;
        bh=kvp6t8w10Ze8dIgCBPO8HLKm/rvJ5YhMMQ+jrvC2iEA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TWE7pdpf12E98D98ckBIUkafqJW4/75ZoO++oyG6DkAUh0jTYhLuOTGfaaFY8kHVy
         WsO3Hq0SRzIKncJKj97rPaOc96lQMNGTyB10pQw1X2sFXpVHjhnxm8GIilGPtnHa6f
         n391luRwMmaOVudGOyi8AwzI/cZFGygu5NLFLFJXB1NM2ZJ7znatLys3zH8fxpyARq
         s8Rgtkdza6SN40gF0+sogTI9iiQhGt03R6xpMc3nwqg7BYjnuct9WehjLURqtq2uG6
         fu6yaON7fQlr4KPQYbLFA/+iCTnUEcpszH9NuAxpoInYghk6AlGyJyjywUbk/peJvX
         iIkVwFwO5VtLw==
Date:   Mon, 14 Aug 2023 11:35:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: hid-google-stadiaff: add support for Stadia
 force feedback
In-Reply-To: <20230716204834.2879106-1-fabiobaltieri@chromium.org>
Message-ID: <nycvar.YFH.7.76.2308141135390.14207@cbobk.fhfr.pm>
References: <20230716204834.2879106-1-fabiobaltieri@chromium.org>
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

On Sun, 16 Jul 2023, Fabio Baltieri wrote:

> Add a hid-google-stadiaff module to support rumble based force feedback
> on the Google Stadia controller. This works using the HID output
> endpoint exposed on both the USB and BLE interface.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>

Now queued in hid.git#for-6.6/google.

Thanks,

-- 
Jiri Kosina
SUSE Labs

