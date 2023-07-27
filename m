Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37887648CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjG0HgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjG0Hfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3EAD29;
        Thu, 27 Jul 2023 00:25:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEF0761D46;
        Thu, 27 Jul 2023 07:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14945C433C8;
        Thu, 27 Jul 2023 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690442712;
        bh=lEyPRYCO9N1DUUoHfYju2Ygxeyp6MfQG8t7Xckc9aEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6NgDr31vXG/KzGtmo1L6ZoZLewtye/NCs6+BZIXXUw/kDHMGE1gny67p2IENliCW
         qw2WlC147TZmwq+ZzzstJHLfvAfUCfMmbuBAb34PDhQCy3AOjU9g9Su2rgvRVkDfXn
         WNbFq41sD2V3gL20zh5rOSlLDHOa/KHK1IXfSdcYTyskh8o7XhxDJqrXOuZlLbQC2L
         bjZe9zYdNDT2de3rlpqd7mG9jM7lu0eTNcrrAFRIQZSbC2sFdVGL27MpLT1jl0Ivtv
         Bg87i4Mr45M5BnORhWg7wKJCs0fSaT7l/ryvYxx3kEl/uFEuAtQsBVtJd6gr9tQ9BR
         nxWoSSt3UQHKw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOvNJ-0008UQ-2J;
        Thu, 27 Jul 2023 09:25:29 +0200
Date:   Thu, 27 Jul 2023 09:25:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hemantg@quicinc.com
Subject: Re: [PATCH v13 0/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZMIb6RWvhvtteRXE@hovoldconsulting.com>
References: <20230727044011.965205-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727044011.965205-1-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 12:40:09PM +0800, Tim Jiang wrote:
> This series adds support for qualcomm bluetooth soc qca2066
> 
> Changes in v13
>  - change the subject name for patch 1/2
>  - solve review comments for patch 2/2

Again, this is not specific enough and essentially only explains why you
changed something, but doesn't say what you changed.

You also again ignored some of my review comments without even
explaining why.

Seriously, you Qualcomm engineers really need to get your act together
and stop wasting other people's time.

Johan
