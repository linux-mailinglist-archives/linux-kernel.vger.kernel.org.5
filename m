Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82C27A4CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjIRPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjIRPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:40:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CF1700;
        Mon, 18 Sep 2023 08:36:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C39DC433CB;
        Mon, 18 Sep 2023 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695042391;
        bh=uELFxgg6luhZsQ6sujsfEcWItHVAhzczR4NVsG10qcU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KBnlnyYaK1LdRDeFtgwXGZc/qRIf6Y+2rDelLlO2EbGIrkbPJUNLdyEWV0x96odTf
         nx2m4KU9g2rFZNIjdGkEXkvkYpOjXQB37/tw3R2wj3MDLallfnorT6S6TzNazK/2yz
         10bW9gxs/HV50u4nyA8EgvKw2T4dcbUei4GpHcl1s+62zm7DOEO2MENlQpzNXa3FCK
         mn4QPaDf7KsTwxfNxQM2wDC0DOLfrMh/YzsiTvaicp7WZnNon/a42hyUSYsLeGi+nG
         UFOxpCL2TaQ1xoCAinezCzAc7vYIM5SiJ2YhL8PYLUF/2Nt+sMpgACej+TLZuaz/I1
         +Z9Fox8jmuEWA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Matthew Wang <matthewmwang@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        linux-wireless@vger.kernel.org,
        Polaris Pi <pinkperfect2021@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix oob check condition in
 mwifiex_process_rx_packet
References: <20230908104308.1546501-1-treapking@chromium.org>
        <ZQIcDWKrmgoPkwlN@google.com>
        <CAEXTbpc=QC6wC-W2VZCaRCp6rSpyNSsq5M6cxNcqAQxciNj0vg@mail.gmail.com>
        <ZQOZZZgHP2EeDNix@google.com>
        <CABRiz0ph56X48Y0VjS1yDEUW3=kihE4+WSHPuFVQv-CCdR=0cw@mail.gmail.com>
Date:   Mon, 18 Sep 2023 16:06:27 +0300
In-Reply-To: <CABRiz0ph56X48Y0VjS1yDEUW3=kihE4+WSHPuFVQv-CCdR=0cw@mail.gmail.com>
        (Matthew Wang's message of "Mon, 18 Sep 2023 09:50:37 +0200")
Message-ID: <8734zbd418.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wang <matthewmwang@chromium.org> writes:

> lgtm
>
> Reviewed-by: Matthew Wang <matthewmwang@chromium.org>

Please don't top post, it's just bad in so many levels. This has been
discussed and explained in our docs so many times that I'm not going to
repeat those anymore. If you are too busy to edit your quotes and reply
properly then it's better not to reply at all.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
