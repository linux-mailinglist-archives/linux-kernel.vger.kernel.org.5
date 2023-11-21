Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA97F2CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjKUMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjKUMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:19:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C852C184
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:18:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FD6C433C7;
        Tue, 21 Nov 2023 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700569137;
        bh=+hDiI7oA7w2GVAiKg2/RFvVoNsawMCCEwiX6G5phNJ8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LevDvwMan1rONnWihkR90a2UXVXOxJMe0dC483raqXQpEMIEu+uKEa6ToFNQNa2bc
         P2u8bTE1sVIMrVO9RctbSdAsezzzk8gHiMd3rNi1Zj31nWUDAXza+LruXoZW5cfeMc
         SWQ+QRqZDiQduSTiN2WnsbHQ3HA1Hutbe5uTA/94N/HOObrOExfPsXO0njuuBAyaNy
         dcer9ztuHU0f3jRGbTMZJGvjEVjzK9SuswXim5Fqi9eWfkt/bro1jeInIk4Vp3do8D
         Pwnf8NZXrmxjeE3YMyEZP1rKyXNgFxzxlPh6NdSlAOGMlSSdgFFo8rWwMW5p2hBW6k
         OYmc5DbUoyuZA==
Date:   Tue, 21 Nov 2023 13:18:54 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/6] tty: ipwireless: remove unused
 ipw_dev::attribute_memory
In-Reply-To: <20231121103626.17772-3-jirislaby@kernel.org>
Message-ID: <nycvar.YFH.7.76.2311211318360.29220@cbobk.fhfr.pm>
References: <20231121103626.17772-1-jirislaby@kernel.org> <20231121103626.17772-3-jirislaby@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:

> clang-struct [1] found ipw_dev::attribute_memory unused.
> 
> As far as I can see it was never used since the driver merge. Drop it.
> 
> [1] https://github.com/jirislaby/clang-struct
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>

FWIW

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

