Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E27E9268
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 21:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjKLUEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 15:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 15:04:23 -0500
X-Greylist: delayed 358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 12:04:19 PST
Received: from mail.gnu-linux.rocks (unknown [82.165.184.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F91FFB;
        Sun, 12 Nov 2023 12:04:19 -0800 (PST)
Received: from localhost.localdomain (ip5f5be8be.dynamic.kabel-deutschland.de [95.91.232.190])
        by mail.gnu-linux.rocks (Postfix) with ESMTPSA id E1D4E3FF28;
        Sun, 12 Nov 2023 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnu-linux.rocks;
        s=mail; t=1699819100;
        bh=KnudzStFE2cldjxqz5zKtdvJz6QG1VHUiZ8lWW0Ruos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAtdUVWo2B/VWIJI05/4KZSRLuEU0oqRpj9EhPT96wrlnAUbAV5kfnMSeDjIfcYg6
         pj7AIQppKKexu0ByJx7d3ZRggX3HGSB02tU8YmPTr9B8FbHMNiRssFBw+PkEP28F7H
         TqwkGH9PRniynS1ZVNlcTT5tn59he7UqoJpIPghSdE311fSlO2Ikvr0B8wOG/NCVH4
         jN0MzmoSZWibi8/lMDTmlqnNC9XHq7/OgdXGWb1FEzlVF/6ArvUsTeeRF6ALjhw6c6
         8Z37jwxJvMWyefB9e0UQps26Q4RG13xsXYQig6Yei/MlN/6vQ+G+lxT79s/X3v53pQ
         grJKNVjXb506g==
From:   Johannes Roith <johannes@gnu-linux.rocks>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org
Cc:     sergeantsagara@protonmail.com, andi.shyti@kernel.org,
        christophe.jaillet@wanadoo.fr, johannes@gnu-linux.rocks,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v7] HID: mcp2200: added driver for GPIOs of MCP2200
Date:   Sun, 12 Nov 2023 20:58:12 +0100
Message-ID: <20231112195812.243155-1-johannes@gnu-linux.rocks>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <87r0mqhlp6.fsf@protonmail.com>
References: <87r0mqhlp6.fsf@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers, 

my patch has undergone review by Rahul Rameshbabu, and I have addressed the feedback accordingly.

I understand that you all have busy schedules, and I appreciate the time and effort you dedicate to maintaining the Linux kernel. However, I would be grateful if you could provide an update on the patch's status and whether there are any further actions required from my end.

Best regards,
Johannes Roith
