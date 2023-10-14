Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB97C91B9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJNAOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNAOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:14:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE583B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:14:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163FCC433C7;
        Sat, 14 Oct 2023 00:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697242492;
        bh=IUwDc+lIbs+tTFWl8nq5IDKM2QYm+ksyEv0F8kZhp3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lx+uf/l9SI6HIFcz+uW+QZJ4k70XyX9z9hPgBKjc4fvooJOq52KCYpBAul8q4BoQU
         BIs3UeAqoHcMsvoqhtNMXelMTDmxVrwE76C1IZm1mhFN9BZhWW6/UD5p4CPkVoc8EJ
         zCMeHroyrrR9jk5h3SklLiCMgKgjf4O0cB5O6IzdFRnsVQ7WofLhwJzQ3IQmdj8qBj
         JjA0D2k4GsBF+aqrnZn1XZhp/1VLcNpnSU4v2XgAugOaXfzPi0XAUyw4DBtsDT6GmP
         74gWs0M9acXih72fg5NrZDWPU+LfpPJgruQFbQ6NyXGm9fDknNZ6LyuUYSVOU1KyTu
         KuIBUp/1f5L/g==
Date:   Fri, 13 Oct 2023 17:14:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     chenguohua@jari.cn
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] etherdevice: Clean up errors in etherdevice.h
Message-ID: <20231013171451.48a2d11a@kernel.org>
In-Reply-To: <22a751c6.93b.18b26b780d4.Coremail.chenguohua@jari.cn>
References: <22a751c6.93b.18b26b780d4.Coremail.chenguohua@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 09:47:22 +0800 (GMT+08:00) chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: that open brace { should be on the previous line

Please do not send any checkpatch fixes to networking.
-- 
pw-bot: reject
