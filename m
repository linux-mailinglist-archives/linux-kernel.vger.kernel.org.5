Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0407FB2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbjK1HkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbjK1HkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE965D4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:40:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06171C433C8;
        Tue, 28 Nov 2023 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701157225;
        bh=sQ8eFRy8ecWkoljPx54B1yii7txseyEFBs2HyY8n+wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0CknmWSAvMLQx5OiL5X7KW4Iw2Mrbo6oKxUPdjCYpr07sE0c/WFbDsrkiNm1pS4g7
         XdHyAQUn9+EDO59QVR6mA2OIJabxl1GhzzO0w44IMVaEAjwOyn4iMloe/g/P80fLVW
         l1/Kojo5fk1mip0XLmakL/SIJxPquRGz46TiouYo=
Date:   Tue, 28 Nov 2023 07:40:21 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] Support new card reader rts5264
Message-ID: <2023112848-handoff-wistful-dec5@gregkh>
References: <d166d6a70c46419f8d2670e63f542ea1@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d166d6a70c46419f8d2670e63f542ea1@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:32:47AM +0000, Ricky WU wrote:
> Summary
> =======
> This series adds support new card reader rts5264
> rts5264 can support sd express card 
> new definitions and functions define in new file rts5264.h rts5264.c
> 
> Patch structure
> ===============
> v4->v5:
> add summary for this series

That is not what I asked for here.  Please make the changelog text for
the individual patches MUCH better.  Perhaps work with one of your
coworkers to come up with some more text that properly describes what
the change is doing?  Did you read the documentation link that I pointed
you at that should answer how to do this better?

Also, your patches are NOT properly linked together (look at them on
lore.kernel.org for proof), please use something like git send-email to
have them be linked so that we can apply them properly at the same time
together once they are ready.

thanks,

greg k-h
