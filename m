Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B785C7CF07E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbjJSGyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjJSGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:54:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4511B;
        Wed, 18 Oct 2023 23:54:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9181CC433C8;
        Thu, 19 Oct 2023 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697698459;
        bh=ruiX0CYxDFoyNxa4DATUzK5KU/dtx/Ss2GAOa2jjwhM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LRyLmDd//J3ERZs1prUDsUlP9kQOwZGM2okfFDmJXb4ViJFTK6A5hwB7p4TLIOqZ4
         ypdz+5MBupTheafBI6bfCrxB3cfIuAYcV7jrMNiathXy3akX6XoPXNvb+upi9OMJZ4
         z+eo+b2CpCgiRxHi3TLyosGiFpMOP47Fh5nOjFqA9LSe10HWev6MaDoh3XeQGHq+v0
         q8v90p6leLHwuDTWfxI2RMwz7fw3AioGtjJYh3kUC3EJ10Ubil1urorbt9WjwgreT5
         ufRTuKPSqYOAjVGEq+onE5a2PKWu4K423Erwz4J7ew0O+CpYG2S/N/zmRlxJzMXqFt
         nJ3BA+yCqJwIQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: Clean up errors in ssb.h
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <54aacb43.944.18b2707fa87.Coremail.chenguohua@jari.cn>
References: <54aacb43.944.18b2707fa87.Coremail.chenguohua@jari.cn>
To:     chenguohua@jari.cn
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169769845642.117236.13039053630570554547.kvalo@kernel.org>
Date:   Thu, 19 Oct 2023 06:54:18 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chenguohua@jari.cn wrote:

> Fix the following errors reported by checkpatch:
> 
> ERROR: "foo * bar" should be "foo *bar"
> 
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

We prefer not to take checkpatch fixes unless explicitly requested by
the maintainers.

Patch set to Rejected.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/54aacb43.944.18b2707fa87.Coremail.chenguohua@jari.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

