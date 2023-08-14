Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A677B5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjHNJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjHNJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135B8109;
        Mon, 14 Aug 2023 02:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4945641D7;
        Mon, 14 Aug 2023 09:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B58CC433C9;
        Mon, 14 Aug 2023 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692006096;
        bh=u7SdiR6jWnCG84+2wK1j3VuaCet8DrxkXNOWsdw6R7k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=qJ+l4crvgV6SV/Ej+nCEAYBih5PnfqLpfFSyQVf7jMo6EsZjUyp5PhgQ6dRS4GjgP
         w/1/r2u1qhz876pfhNGK9sCBqLcvtwYH9pYYW+SNEShhj1ZtWYNSqWOFQeaF9iksso
         /btsK0iBF+LqOG/IhFkPssnvr34UFkGm/zN0UQecNHgRDgTlIDBM3DY/tmsLWJfWqJ
         dTJzYQgAxgzge99CFOFnzr7nWyyEHxqaYVAEfh3jw4bz9toZ0UYZ3i2jzforB3t+yX
         zcrfUebKMXR1dFS5nYVBu3Ar0cA0myVFnJ25K7gfymdHOtFIa3fxEi/mAG+tNGNmtH
         C47XmcQuWR+OQ==
Date:   Mon, 14 Aug 2023 11:41:32 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: nvidia-shield: Remove led_classdev_unregister
 in thunderstrike_create
In-Reply-To: <20230807163620.16855-1-rrameshbabu@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2308141141190.14207@cbobk.fhfr.pm>
References: <20230807163620.16855-1-rrameshbabu@nvidia.com>
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

I have now applied the series to hid.git.

Thanks,

-- 
Jiri Kosina
SUSE Labs

