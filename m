Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B527B6835
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbjJCLoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjJCLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:44:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FDCC;
        Tue,  3 Oct 2023 04:44:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B88C433C8;
        Tue,  3 Oct 2023 11:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696333469;
        bh=yaYF8nb6MGq8t2g+aVZfQLDiwQe8acgckiqnV2dLxv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1L016eKkQnPRYFTSWXF1ICWSxYD9w/kulER6Q0Vn4uQ54bsfWsMXdtAgc/Uo6LAy
         KKua71HQnxSZjZeS2NejRYQ4/35slOsJ8wakBSFgTixqx5lY+J+tCI1bT13O1KbaJz
         YFPI5eJgWlRzM7y2LwWXuxARgq9FY/MsPQwidvhth2Af0cEt+CyW3vx/rc2KfvLkWH
         e8UfwKONycNVRdszAUNRYe937PQwLjlXCpv+vA+fzF8hgALt7/l0OEekuaeJfJomEc
         RqvSafdTDpgAL6xcyfnGUJcPYhrFCrTgkCcLi1BRLyco/43YW8YBAyvFbXL06rdR8e
         z53YvalJqqOog==
Date:   Tue, 3 Oct 2023 13:44:24 +0200
From:   Simon Horman <horms@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: cfg80211: fix header kernel-doc typos
Message-ID: <ZRv+mApb7siTqWg7@kernel.org>
References: <20231001191633.19090-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001191633.19090-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:16:31PM -0700, Randy Dunlap wrote:
> Correct spelling of several words.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>

