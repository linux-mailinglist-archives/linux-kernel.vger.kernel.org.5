Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA97B1E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjI1NYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjI1NYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:24:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3717211F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:21:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C5AC433C7;
        Thu, 28 Sep 2023 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907305;
        bh=svq8d0SVR8XmGLiuL7Stnbfu6iif8GF57IXKbLgJ+Fw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bKvsSY3hIN3yKaIhCX4oQYXIi4CUMSPcmY4yzd1TK8bAqZ6vLl6q7ykqmbtJEJl6w
         7gJCdY75QOrhxvzC+akxmfAVc5QQujtzRtHEXU0QqOoovgNvS8ovFvopPvCWwbIk6V
         Ec+7XiKEBXytmlT0F42iG733inftYVhcKYmjr6/Bo4OL0eh4dk2tGLouOYJqAvvyUT
         eQELNnOCSl3HxlWQMeZz5zBGL4WKlGidQ8F3GmrD6UWGH7US0WCKycjp9nMw9LXA8s
         ZBaqr0iacdGg4S74fQTL3m8T8nE6TfuhSMmZwcX7zs3rymNAs3N7wtz6RRtf6G1pJp
         Fkn9SnDnBO9aw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230923174928.56824-1-biju.das.jz@bp.renesas.com>
References: <20230923174928.56824-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4 0/4] Simplify obtaining I2C match data
Message-Id: <169590730318.1592771.10390430417774120111.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 14:21:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2023 18:49:24 +0100, Biju Das wrote:
> This patch series aims to simplify obtaining I2C match data.
> 
> This patch series is only compile tested.
> 
> v4:
>  * Added as a series
>  * Updated commit header for all patches
>  * Updated commit description for patch#1.
> 
> [...]

Applied, thanks!

[1/4] mfd: arizona-i2c: Simplify obtaining I2C match data
      commit: 33b5b46a3bd2664a32568f7df2c7b5fd9d2873ae
[2/4] mfd: madera-i2c: Simplify obtaining I2C match data
      commit: 7a6ff7d69d9921d269b796ca0c2a96717563fe84
[3/4] mfd: max77541: Simplify obtaining I2C match data
      commit: 9abf37d4bbb20d6fb6e15a73d8e8247c8e791f46
[4/4] mfd: max8998: Simplify obtaining I2C match data and drop max8998_i2c_get_driver_data()
      commit: 36270a2599628fbd8052b3d9241f4a4b02faea7c

--
Lee Jones [李琼斯]

