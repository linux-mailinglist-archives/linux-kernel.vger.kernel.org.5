Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E17F4B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbjKVPvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjKVPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:50:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668249A;
        Wed, 22 Nov 2023 07:50:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2681BC433C9;
        Wed, 22 Nov 2023 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700668253;
        bh=rWqVCb8PYZLmMcO+1AkKEoS6rSzHSai5rlDh5ai/OaM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=A+A/g1BDhyOMu8WzSGoPnVv8flPZ+BmTL08SNjdrnsoq0O6V5zFRaGqZDQUrlkl5H
         gqgzwmZJkQWGL6/sZrFU4B3fq2hvBHA1uFKL2grNCw67YPXCdnidLgh9Xutw5leEjS
         TGTEOU7Y5/ZAbeWnLRitFpqtvd7mCIbYsRqd+h3Z6xokw8P88CihxiFZwPdwpiMgnT
         DARugorsdIWCtbx45QT4Z12s2wBCbxwzg1kW+2oFhjqumgYtXGKt524znTBKLGLkGc
         wg7p0nTdg6anA+IIlQl2jHrKnEKQFOJT+D8huJU4Ay2ZoIFcUi8J/SViLXDBs7VQsJ
         QVqSal2mDVbbg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wifi: rtlwifi: drop unused const_amdpci_aspm
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231116180529.52752-1-helgaas@kernel.org>
References: <20231116180529.52752-1-helgaas@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Bither <jonbither@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170066824927.4178710.15359397794712152565.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 15:50:50 +0000 (UTC)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Remove the unused "const_amdpci_aspm" member of struct rtl_pci and
> struct rtl_ps_ctl.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Patch applied to wireless-next.git, thanks.

f60df12aaadd wifi: rtlwifi: drop unused const_amdpci_aspm

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231116180529.52752-1-helgaas@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

